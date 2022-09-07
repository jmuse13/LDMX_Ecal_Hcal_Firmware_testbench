`timescale 1ns / 1ps
module elink_trig_unroller_sim();

  wire [9:0] data_out;
  reg [7:0] data_in;
  reg clk;




  elink_trig_unroller elink_trig_unroller (
    .data_out(data_out),
    .data_in(data_in),
    .clk(clk)
  );

  initial begin
    $dumpfile("elink_trig_unroller.vcd");
    $dumpvars(0,elink_trig_unroller);
    clk=0;
    data_in='b10101111;
    #2;
    data_in='b11111111;
    #2;
    data_in='b01000000;
    #2;
    data_in='b11111111;
    #2;
    #2;
    #2;
    #2;
    #2;
    data_in='b10101111;
    #2;
    data_in='b11111111;
    #2;
    data_in='b00000000;
    #2;
    data_in='b11111111;
    #2;
    #2;
    #2;
    #2;
    #2;
  end
  always begin
    clk = !clk;
    #1;
  end
endmodule