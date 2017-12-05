`include "branchLogic.v"

module branchLogic_fixture;
  reg [15:0] rd1, rd15;
  reg branch;
  output reg PCSRC;

  initial
    $monitor($time, "\n Input:\n Read1: %h,  RD15: %h Branch: %b\nOutput:\n PCSRC: %h")




module branchLogic(
  input [15:0] rd1, rd15;
  input branch;
  output reg PCSRC;
  );

  always@(*)
  begin
    if(branch)
      if(rd1 > rd15)
        PCSRC=0;
      else if(rd1 < rd15)
        PCSRC=0;
      else if(rd1 == rd15)
        PCSRC=0;
    else
      PCSRC=1;
  end
endmodule
