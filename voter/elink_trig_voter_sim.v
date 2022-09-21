`timescale 1ns / 1ps
module elink_trig_voter_sim();

  wire [13:0] voted;
  reg clk;
  reg [11:0] data_in1,data_in2,data_in3;

  elink_trig_voter elink_trig_voter(
    .voted(voted),
    .clk(clk),
    .data_in1(data_in1),
    .data_in2(data_in2),
    .data_in3(data_in3)
  );

  initial begin
    $dumpfile("elink_trig_voter.vcd");
    $dumpvars(0,elink_trig_voter);
    clk=0;
    data_in1='b111111111111;
    data_in2='b111111111111;
    data_in3='b111111111111;
    #5;
    data_in1='b000000000000;
    data_in2='b111111111111;
    data_in3='b111111111111;
    #5;
    data_in1='b000000000000;
    data_in2='b000000000000;
    data_in3='b111111111111;
    #5;
    data_in1='b000000000111;
    data_in2='b000000000000;
    data_in3='b111111111111;
  end
  always begin
    clk = !clk;
    #1;
  end
endmodule