`timescale 1ns / 1ps
module ram (clk,addr,wr_data,rd_data,rd_enable,wr_enable);

  parameter num_addrs = 4;
  //parameter num_addrs = 128;

  input clk;
  input [num_addrs-1:0] addr;
  input [11:0] wr_data;
  input rd_enable;
  input wr_enable;

  output reg [11:0] rd_data;

  reg [11:0] memory [num_addrs-1:0];

  initial begin
    memory ['d0]<= 'b111111111111;
    memory ['d1]<= 'b000000000000;
    memory ['d2]<= 'b111111111111;
    memory ['d3]<= 'b000000000000;
  end

  always @(posedge clk) begin
    if(rd_enable)
      rd_data<=memory[addr];
    else if(wr_enable)
      memory[addr]<=wr_data;
  end
endmodule