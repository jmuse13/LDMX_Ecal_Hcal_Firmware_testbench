`timescale 1ns / 1ps
module elink_trig_scrubber_sim();

  reg clk;
  reg [3:0] i_wb_addr;
  reg i_wb_stb;
  wire [9:0] o_wb_data;
  wire o_wb_ack;
  wire o_wb_stall;

  elink_trig_scrubber elink_trig_scrubber(
    .clk(clk),
    .i_wb_addr(i_wb_addr),
    .i_wb_stb(i_wb_stb),
    .o_wb_data(o_wb_data),
    .o_wb_ack(o_wb_ack),
    .o_wb_stall(o_wb_stall)
  );

  initial begin
    $dumpfile("elink_trig_scrubber.vcd");
    $dumpvars(0,elink_trig_scrubber);
    clk=0;
    i_wb_addr='d1;
    i_wb_stb=0;
    #10;
    i_wb_addr='d0;
    i_wb_stb=1;
    #10;
    i_wb_addr='d0;
    i_wb_stb=0;
  end
  always begin
    clk =! clk;
    #1;
  end
endmodule