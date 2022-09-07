module elink_trig_unroller(clk,reset,data_in,data_out);

  input clk;
  input reset;
  input [7:0] data_in;

  output reg [9:0] data_out;

  reg [9:0] mem [3:0];
  reg [2:0] count;
  reg valid;

  initial count = 'd0;
  initial valid = 0;

  always @(posedge clk) begin
    if (reset) begin
      count <= 'd0;
      valid <= 0;
    end
    if(data_in[7:4]=='b1010) begin
      valid <= 1;
      mem['d0][9] <= 1;
      mem['d0][8:7] <= 'd0;
      mem['d0][6:3] <= data_in[3:0];
      count <= 'd1;
    end else if( count=='d1 ) begin
      mem['d0][2:0] <= data_in[7:5];
      mem['d1][9] <= valid;
      mem['d1][8:7] <= 'd1;
      mem['d1][6:2] <= data_in[4:0];
      count <= 'd2;
    end else if( count=='d2 ) begin
      mem['d1][1:0] <= data_in[7:6];
      data_out <= mem['d0];
      mem['d2][9] <= valid;
      mem['d2][8:7] <= 'd2;
      mem['d2][6:1] <= data_in[5:0];
      count <= 'd3;
    end else if( count=='d3 ) begin
      mem['d2][0] <= data_in[7];
      data_out <= mem['d1];
      mem['d3][9] <= valid;
      mem['d3][8:7] <= 'd3;
      mem['d3][6:0] <= data_in[6:0];
      count <= 'd4;
    end else if(count=='d4) begin
      data_out <= mem['d2];
      count <= 'd5;
    end else if(count=='d5) begin
      data_out <= mem['d3];
      count <= 'd0;
      valid <= 0;
    end
  end
endmodule