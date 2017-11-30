`include "EXMBuffer.v";

module EXMBuffer_fixture;
  //in order of appearance on EXMBuffer
  reg [15:0] ALU_Result, ALU_Remainder;
  reg [3:0] movOP_in;

  reg MemToReg_in, MemWrite_in, MemRead_in, R15_in, FLUSH_EX, RegWrite;
  reg [3:0] IDEX_RegRD;

  //Wires
  wire MemtoReg_out, MemWrite_out, MemRead_out, R15_out, RegWrite_out;
  wire ALU_Result_out, ALU_Remainder_out, movOp_out, EXM_RegRD_out;

  initial
  $monitor($time, " Input: \n ALU Result = %h ALU_Remainder = %h MovOP = %h\n Signals In: \n MemToReg: %b MemWrite: %b MemRead: %b R15: %b Flush: %b RegWrite: %b \n Forward In IDEX_RegRD: %h \n Outputs: \n MemToReg: %b MemWrite: %b MemRead: %b R15: %b RegWrite: %b\n ALU Result: : %b ALU Remainder: %b MovOp: %b EXM_REGRD: %b", ALU_Result, ALU_Remainder, movOP_in, MemToReg_in, MemWrite_in, MemRead_in, R15_in, FLUSH_EX, RegWrite, IDEX_RegRD, MemToReg_out, MemWrite_out, MemRead_out, R15_out, RegWrite_out, ALU_Result_out, ALU_Remainder_out, movOp_out, EXM_RegRD_out);

  EXMBuffer buffythEXMpireSlayer(ALU_Result, ALU_Remainder, movOP_in, MemToReg_in, MemWrite_in, MemRead_in, R15_in, FLUSH_EX, RegWrite, IDEX_RegRD, MemToReg_out, MemWrite_out, MemRead_out, R15_out, RegWrite_out, ALU_Result_out, ALU_Remainder_out, movOp_out, EXM_RegRD_out);

  initla begin
  #10
  FLUSH_EX = 0;
  ALU_Result = 15;
  ALU_Remainder = 12;
  movOp_in = 3;
  //W
  MemToReg_in = 1;
  MemWrite_in = 1;
  MemRead_in = 1;
  R15_in = 1;
  RegWrite = 1;
  IDEX_RegRD = 4'b0101;

  #20
  FLUSH_EX = 1;
  ALU_Result = 15;
  ALU_Remainder = 12;
  movOp_in = 3;
  //W
  MemToReg_in = 1;
  MemWrite_in = 1;
  MemRead_in = 1;
  R15_in = 1;
  RegWrite = 1;
  IDEX_RegRD = 4'b0101;
  #20
  FLUSH_EX=0;
  ALU_Result = 6;
  ALU_Remainder = 8;
  movOp_in = 5;
  //W
  MemToReg_in = 0;
  MemWrite_in = 1;
  MemRead_in = 1;
  R15_in = 0;
  RegWrite = 1;
  IDEX_RegRD = 4'b1100;
end
initial begin
 #1000 $finish;
 end
endmodule
