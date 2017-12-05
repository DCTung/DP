`include "branchLogic.v"

module branchLogic_fixture;
  reg [15:0] rd1, rd15;
  reg [3:0]opcode;
  reg branch;
  wire PCSRC;

  initial
    $monitor($time, "\n Input:\n Read1: %h,  RD15: %h opcode: %b Branch: %b\nOutput:\n PCSRC: %b\n", rd1, rd15, opcode, branch, PCSRC);

  branchLogic BL_FIX(rd1, rd15, opcode, branch, PCSRC);
  initial begin
    #5 rd1 = 5; rd15 = 15; branch=1; opcode= 0101;
    #5 rd1 = 5; rd15 = 15; branch=1; opcode= 0100;
    #5 rd1 = 5; rd15 = 15; branch=0; opcode= 0101;
    #5 rd1 = 5; rd15 = 15; branch=0; opcode= 0100;
  end
  initial begin
    #420 $finish;
  end
endmodule
