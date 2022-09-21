module elink_trig_voter(clk,data_in1,data_in2,data_in3,voted);

  input [11:0] data_in1;
  input [11:0] data_in2;
  input [11:0] data_in3;

  output reg [13:0] voted;

  input clk;

  always @(posedge clk) begin
    if((data_in1==data_in2) && (data_in1==data_in3)) begin
      voted[13:12]<='d2;
      voted[11:0]<=data_in1;
    end else if(data_in1==data_in2) begin
      voted[13:12]<='d1;
      voted[11:0]<=data_in1;
    end else if(data_in1==data_in3) begin
      voted[13:12]<='d1;
      voted[11:0]<=data_in1;
    end else if(data_in2==data_in3) begin
      voted[13:12]<='d1;
      voted[11:0]<=data_in2;
    end else begin
      voted[13:12]<='d0;
      voted[11:0]<=data_in1;
    end
  end
endmodule