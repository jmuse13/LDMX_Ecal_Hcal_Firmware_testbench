`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Minnesota
// Engineer: Joe Muse
// 
// Create Date: 09/21/2023 03:19:30 PM
// Design Name: LDMX slow control system
// Module Name: slow_control
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


module slow_control(
    input clk,
    input [6:0] tx_GBTx_address_i,
    input read_write_i,
    input [15:0] tx_register_addr_i,
    input [15:0] tx_nb_to_be_read_i,
    input [7:0] parity_err_mask_i,
    input [7:0] tx_data_to_gbtx_i,
    input write_request,
    input reset_fifo,
    input [63:0] DO,
    input EMPTY,
    input FULL,
    input [8:0] RDCOUNT,
    input RDBUSY,
    input [8:0] WRCOUNT,
    input WRBUSY,
    output reg read_clk,
    output reg write_clk,
    output reg [63:0] DI,
    output reg RDEN,
    output reg RST,
    output reg WREN,
    output reg [63:0] out_data,
    output reg int_state,
    output reg out_write_request,
    output reg out_read_request,
    output reg out_fifo_empty,
    output reg out_fifo_full,
    output reg [8:0] out_fifo_rdcount,
    output reg [8:0] out_fifo_wrcount,
    output reg out_fifo_rderr,
    output reg out_fifo_wrerr,
    output reg out_fifo_rden,
    output reg out_fifo_wren
    );
    
  parameter DATA_WIDTH = 'd64;
  parameter DEVICE = "7SERIES";
  parameter FIFO_SIZE = "36Kb";
  parameter FIRST_WORD_FALL_THROUGH = "FALSE";

  parameter BUSY = 0;
  parameter READ = 1;
  parameter WRITE = 2;
  parameter SLEEP = 3;

  //requests from software, write will be sent as input, read will be an internal register
  reg read_request;

  reg state;

  initial begin
    read_request<='d0;
    out_data<='d0;
    int_state<='d3;
    out_write_request<='d0;
    out_read_request<='d0;
    out_fifo_empty<='d0;
    out_fifo_full<='d0;
    out_fifo_rdcount<='d0;
    out_fifo_wrcount<='d0;
    out_fifo_rderr<='d0;
    out_fifo_wrerr<='d0;
    out_fifo_rden<='d0;
    out_fifo_wren<='d0;
    DI<='d0;
    RDEN<='d0;
    RST<='d0;
    WREN<='d0;
    state<='d3;
  end                  

  always #1 read_clk=~clk;
  always #1 write_clk=~clk;
  
  always @(posedge clk) begin
    int_state<=state;
    out_write_request<=write_request;
    out_read_request<=read_request;
    out_fifo_empty<=EMPTY;
    out_fifo_full<=FULL;
    out_fifo_rdcount<=RDCOUNT;
    out_fifo_wrcount<=WRCOUNT;
    out_fifo_rderr<=RDBUSY;
    out_fifo_wrerr<=WRBUSY;
    out_fifo_rden<=RDEN;
    out_fifo_wren<=WREN;
    if(reset_fifo==1) begin
      RST<='d1;
      state<='d3;
    end
    if(reset_fifo==0) begin
      RST<='d0;
    end
    case(state)
    SLEEP:
      if(state==SLEEP) begin
          WREN<='d0;
          RDEN<='d0;
        if(write_request=='d1) begin
          state<='d2;
        end
        if(read_request=='d1) begin
          state<='d1;
        end
      end
    BUSY:
      if(state==BUSY) begin
        if(write_request=='d1 && read_request=='d0 && FULL=='d0 && WRBUSY=='d0) begin
          state<='d2;
        end
        if(read_request=='d1 && write_request=='d0 && EMPTY=='d0 && RDBUSY=='d0) begin
          state<='d1;
        end
      end
    WRITE:
      if(state==WRITE) begin
        WREN<='d1;
        RDEN<='d0;
        if(FULL=='d0 && WRBUSY=='d0) begin
          DI[63:56]<='b01111110;
          DI[55:49]<=tx_GBTx_address_i;
          DI[48:48]<=read_write_i;
          DI[47:32]<=tx_nb_to_be_read_i;
          DI[31:16]<=tx_register_addr_i;
          DI[15:8]<=tx_data_to_gbtx_i;
          DI[7:0]<=parity_err_mask_i;
          state<='d1;
          read_request<='d1;
        end
        if(FULL=='d1 || WRBUSY=='d1) begin
          state<='d0;
        end
      end
    READ:
      if(state==READ) begin
        WREN<='d0;
        RDEN<='d1;
        if(EMPTY=='d0 && RDBUSY=='d0) begin
          out_data<=DO;
          state<='d3;
          read_request<='d0;
        end
        if(EMPTY=='d1 || RDBUSY=='d1) begin
          state<='d0;
        end
      end
    endcase
  end
endmodule
