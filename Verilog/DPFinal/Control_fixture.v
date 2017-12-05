`include "Control.v";

module control_fixture;

reg[3:0] opcode;
wire R15, ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, Branch, ALUOP;

initial
  $monitor($time, " R15: %b, ALUSrc: %b, MemToReg: %b, RegWRite: %b, MemRead: %b, MemWrite: %b, Branch: %b, ALUOP: %b",
            R15, ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, Branch, ALUOP);
  control CUT(opcode,R15, ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, Branch, ALUOP);

  initial begin
    opcode = 4'b1111;
    #5
    opcode = 4'b1000;
    #5
    opcode = 4'b1001;
    #5
    opcode = 4'b1010;
    #5
    opcode = 4'b1011;
    #5
    opcode = 4'b1100;
    #5
    opcode = 4'b1101;
    #5
    opcode = 4'b0101;
    #5
    opcode = 4'b0100;
    #5
    opcode = 4'b0110;
    #5
    opcode = 4'b0001;
    #5
    opcode = 4'b0000;
end
  initial begin
      #100 $finish;
      end
  endmodule


/*
input [3:0] opCode;
output R15;
output ALUSrc;
output MemToReg;
output RegWrite;
output MemRead;
output MemWrite;
output Branch;
output [1:0] ALUOP;
*/
