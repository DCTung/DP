//i'm the control mod

module control(
  input clk, rst;
  input [3:0] opCode;
  output R15;
  output ALUSrc;
  output MemToReg;
  output RegWrite;
  output MemRead;
  output MemWrite;
  output Branch;
  output [1:0] ALUOP;
  );

  always@(*)
  begin
    case(opcode)
    4'b1111: //TypeA
      R15 = 1;
      ALUSrc = 0;
      MemToReg = 1;
      RegWrite = 1;
      MemRead = 0;
      MemWrite = 0;
      Branch = 0;
      ALUOP = 2'b11;

    4'b1000; //AND imm
      R15 = 0;
      ALUSrc = 0;
      MemToReg = 1;
      RegWrite = 1;
      MemRead = 0;
      MemWrite = 0;
      Branch = 0;
      ALUOP = 2'b11;

    4'b1001; //OR imm
      R15 = 0;
      ALUSrc = 1;
      MemToReg = 1;
      RegWrite = 1;
      MemRead = 0;
      MemWrite = 0;
      Branch = 0;
      ALUOP = 2'b10;



/*
    4'b1000:  //Type C
      R15 = 0;
      ALUSrc = 1;
      MemToReg = 1;
      RegWrite = 1;
      MemRead = 0;
      MemWrite = 0;
      Branch = 0;
      ALUOP = 2'b10;

    4'b1010:  //LBU
      R15 = 0;
      ALUSrc = 1;
      MemToReg = 0;
      RegWrite = 1;
      MemRead = 0;
      MemWrite = 0;
      Branch = 0;
      ALUOP = 2'b10;
    */
