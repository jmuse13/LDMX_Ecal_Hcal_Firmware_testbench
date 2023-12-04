`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/21/2023 04:32:08 PM
// Design Name: 
// Module Name: fake_LPGBT
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module fake_LPGBT(
    output reg RDEN,
    input clk,
    input [63:0] DO,
    input EMPTY,
    input FULL,
    input [8:0] RDCOUNT,
    input RDBUSY,
    input [8:0] WRCOUNT,
    input WRBUSY,
    output reg read_clk,
    output reg write_clk,
    output reg RST,
    output reg [63:0] DI,
    output reg WREN
    );
    
    initial begin
      RDEN<='d0;
      DI<='d0;
      WREN<='d0;
      RST<='d0;
    end
    
    always #1 read_clk=~clk;
    always #1 write_clk=~clk;
    
    always @(posedge clk) begin
      if(EMPTY=='d0 && FULL=='d0) begin
        WREN<='d1;
        RDEN<='d1;
        DI<=DO;
      end
      if(EMPTY=='d1) begin
        WREN<='d1;
        RDEN<='d0;
        DI<='d0;
      end
    end
endmodule
