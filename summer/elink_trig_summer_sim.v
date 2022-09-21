`timescale 1ns / 1ps
module elink_trig_summer_sim();

  reg clk;
  reg [11:0] data_in1;
  reg [11:0] data_in2;
  reg [11:0] data_in3;
  reg [11:0] data_in4;

  wire [12:0] data_out;

  elink_trig_summer elink_trig_summer(
    .clk(clk),
    .data_in1(data_in1),
    .data_in2(data_in2),
    .data_in3(data_in3),
    .data_in4(data_in4),
    .data_out(data_out)
  );

  initial begin
    $dumpfile("elink_trig_summer.vcd");
    $dumpvars(0,elink_trig_summer);
    clk=0;
    data_in1='d0;
    data_in2='d0;
    data_in3='d0;
    data_in4='d0;
    #2;
    data_in1='d100;
    data_in2='d100;
    data_in3='d100;
    data_in4='d100;
    #2;
    data_in1='d500;
    data_in2='d500;
    data_in3='d500;
    data_in4='d500;
    #2;
    data_in1='d1000;
    data_in2='d1000;
    data_in3='d1000;
    data_in4='d1000;
    #2;
    data_in1='d1000;
    data_in2='d1000;
    data_in3='d1000;
    data_in4='d1000;
    #2;
    data_in1='d500;
    data_in2='d500;
    data_in3='d500;
    data_in4='d500;
    #2;
    data_in1='d100;
    data_in2='d100;
    data_in3='d100;
    data_in4='d100;
    #2;
    data_in1='d0;
    data_in2='d0;
    data_in3='d0;
    data_in4='d0;
    #2;
    data_in1='d0;
    data_in2='d0;
    data_in3='d0;
    data_in4='d0;
    #2;
    data_in1='d100;
    data_in2='d100;
    data_in3='d100;
    data_in4='d100;
    #2;
    data_in1='d500;
    data_in2='d500;
    data_in3='d500;
    data_in4='d500;
    #2;
    data_in1='d1000;
    data_in2='d1000;
    data_in3='d1000;
    data_in4='d1000;
    #2;
    data_in1='d500;
    data_in2='d500;
    data_in3='d500;
    data_in4='d500;
    #2;
    data_in1='d500;
    data_in2='d500;
    data_in3='d500;
    data_in4='d500;
    #2;
    data_in1='d100;
    data_in2='d100;
    data_in3='d100;
    data_in4='d100;
    #2;
    data_in1='d0;
    data_in2='d0;
    data_in3='d0;
    data_in4='d0;
    #2;
    data_in1='d0;
    data_in2='d0;
    data_in3='d0;
    data_in4='d0;
    #2;
    data_in1='d100;
    data_in2='d100;
    data_in3='d100;
    data_in4='d100;
    #2;
    data_in1='d500;
    data_in2='d500;
    data_in3='d500;
    data_in4='d500;
    #2;
    data_in1='d1000;
    data_in2='d1000;
    data_in3='d1000;
    data_in4='d1000;
    #2;
    data_in1='d1000;
    data_in2='d1000;
    data_in3='d1000;
    data_in4='d1000;
    #2;
    data_in1='d500;
    data_in2='d500;
    data_in3='d500;
    data_in4='d500;
    #2;
    data_in1='d100;
    data_in2='d100;
    data_in3='d100;
    data_in4='d100;
    #2;
    data_in1='d0;
    data_in2='d0;
    data_in3='d0;
    data_in4='d0;
  end
  always begin
    clk =! clk;
    #1;
  end
endmodule