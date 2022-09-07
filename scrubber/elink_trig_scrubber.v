module elink_trig_scrubber(clk,i_wb_addr,i_wb_stb,data_in1,data_in2,data_in3,o_wb_data,o_wb_ack,o_wb_stall);

  parameter num_addrs = 4;
  parameter max_addr = 3;
  parameter WRITE_WB = 0;
  parameter SCRUBBING = 1;

  input clk;
  input [num_addrs-1:0] i_wb_addr;
  input i_wb_stb;

  output reg [9:0] o_wb_data;
  output reg o_wb_ack;
  output reg o_wb_stall;
  output reg [9:0] data_in1;
  output reg [9:0] data_in2;
  output reg [9:0] data_in3;

  reg [num_addrs-1:0] addr;
  reg [num_addrs-1:0] count_addr;
  reg [2:0] count;
  reg [9:0] wr_data [2:0];
  reg wr_enable;
  reg rd_enable;
  reg state;

  wire [11:0] voted;
  wire [9:0] rd_data [2:0];

  genvar i;
  generate
    for (i=0; i<=2; i=i+1) begin
      ram ram (
        .clk    (clk),
        .addr     (addr),
        .wr_data  (wr_data[i]),
        .rd_data  (rd_data[i]),
        .rd_enable (rd_enable),
        .wr_enable (wr_enable)
      );
    end
  endgenerate

  elink_trig_voter elink_trig_voter(
    .voted(voted),
    .clk(clk),
    .data_in1(data_in1),
    .data_in2(data_in2),
    .data_in3(data_in3)
  );

  initial begin
    state<=SCRUBBING;
    o_wb_stall<=0;
    o_wb_ack<=0;
    count_addr<='d1;
    addr<='d0;
    count<='d0;
    rd_enable<='d0;
    wr_enable<='d0;
  end

  always @(posedge clk) begin
    case(state)
    WRITE_WB:
      if(state==WRITE_WB) begin
        if(count=='d0) begin
          if((i_wb_stb)&&(!o_wb_stall)) begin
            rd_enable<=1;
            wr_enable<=0;
            o_wb_ack<=0;
            addr<=i_wb_addr;
            count<='d1;
          end if((!i_wb_stb)||(o_wb_stall)) begin
            rd_enable<=0;
            wr_enable<=0;
            state<=SCRUBBING;
            addr<=count_addr;
          end
        end if(count=='d1) begin
          rd_enable<=0;
          wr_enable<=0;
          count<='d2;
        end if(count=='d2) begin
          rd_enable<=0;
          wr_enable<=0;
          o_wb_data<=rd_data[0];
          o_wb_ack<=1;
          count<='d0;
        end
      end
    SCRUBBING:
      if(state==SCRUBBING) begin
        if((!i_wb_stb)&&(count=='d0)) begin
          rd_enable<=1;
          wr_enable<=0;
          o_wb_ack<=0;
          o_wb_stall<=1;
          data_in1<=rd_data[0];
          data_in2<=rd_data[1];
          data_in3<=rd_data[2];
          count<='d1;
        end if(i_wb_stb&&(o_wb_stall=='d0)) begin
          rd_enable<=0;
          wr_enable<=0;
          o_wb_ack<=0;
          o_wb_stall<=0;
          state<=WRITE_WB;
        end if(count=='d1) begin
          rd_enable<=0;
          wr_enable<=0;
          count<='d2;
        end if(count=='d2) begin
          rd_enable<=0;
          wr_enable<=1;
          wr_data[0]<=voted[9:0];
          wr_data[1]<=voted[9:0];
          wr_data[2]<=voted[9:0];
          count<='d3;
        end if(count=='d3) begin
          rd_enable<=0;
          wr_enable<=0;
          o_wb_stall<=0;
          addr<=count_addr;
          if(count_addr==max_addr)
            count_addr<=0;
          else
            count_addr = count_addr + 'd1;
          count<='d0;
        end
      end
    endcase
  end
endmodule