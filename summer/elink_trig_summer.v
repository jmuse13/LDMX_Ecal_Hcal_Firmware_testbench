module elink_trig_summer(clk,data_in1,data_in2,data_in3,data_in4,data_out);

  parameter multisample = 8;

  input clk;
  input [11:0] data_in1;
  input [11:0] data_in2;
  input [11:0] data_in3;
  input [11:0] data_in4;

  output reg [12:0] data_out;

  reg [12:0] circle_ram [multisample+multisample-1:0];
  reg [12:0] high_value;
  reg [multisample:0] read_count;
  reg [multisample:0] write_count;
  reg [12:0] sum;
  reg done;

  initial begin
    circle_ram['d0]<='d0;
    circle_ram['d1]<='d0;
    circle_ram['d2]<='d0;
    circle_ram['d3]<='d0;
    circle_ram['d4]<='d0;
    circle_ram['d5]<='d0;
    circle_ram['d6]<='d0;
    circle_ram['d7]<='d0;
    circle_ram['d8]<='d0;
    circle_ram['d9]<='d0;
    circle_ram['d10]<='d0;
    circle_ram['d11]<='d0;
    circle_ram['d12]<='d0;
    circle_ram['d13]<='d0;
    circle_ram['d14]<='d0;
    circle_ram['d15]<='d0;
    read_count<='d8;
    write_count<='d0;
    high_value<='d0;
    done<=0;
  end

  always @(posedge clk) begin
    sum<=data_in1+data_in2+data_in3+data_in4;
    data_out<=circle_ram[read_count];
    if(sum<high_value && done==0) begin
      circle_ram[write_count]<=high_value;
      done<=1;
    end if (sum>=high_value) begin
      circle_ram[write_count]<=0;
    end if (write_count!='d7 && write_count!='d15) begin
      high_value<=sum;
    end if (write_count=='d7 || write_count=='d15) begin
      high_value<='d0;
      done<=0;
    end if (read_count==multisample+multisample-1) begin
      read_count<='d0;
    end if (read_count<multisample+multisample-1) begin
      read_count<=read_count + 'd1;
    end if (write_count==multisample+multisample-1) begin
      write_count<='d0;
    end if (write_count<multisample+multisample-1) begin
      write_count<=write_count + 'd1;
    end
  end
endmodule
