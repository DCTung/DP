`include "control.v";

module control_fixture;
reg clk, reset;
reg[3:0] opcode;
wire R15, ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, Branch, ALUOP;

initial
  $monitor($time, "reset = %b, opcode = %b, R15: %b, ALUSrc: %b, MemToReg: %b, RegWRite: %b, MemRead: %b, MemWrite: %b, Branch: %b, ALUOP: %b",
            reset,opcode,  R15, ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, Branch, ALUOP);
  control CUT(clk, reset, opcode,R15, ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, Branch, ALUOP);

initial 
begin
	clk = 1'b1;
	forever #10 clk = !clk;
end 
  initial begin
    reset = 1;
    #20 reset = 0;
    opcode = 4'b1111;
    #20
    opcode = 4'b1000;
    #20
    opcode = 4'b1001;
    #20
    opcode = 4'b1010;
    #20
    opcode = 4'b1011;
    #20
    opcode = 4'b1100;
    #20
    opcode = 4'b1101;
    #20
    opcode = 4'b0101;
    #20
    opcode = 4'b0100;
    #20
    opcode = 4'b0110;
    #20
    opcode = 4'b0001;
    #20
    opcode = 4'b0000;
end
  initial begin
      #800 $finish;
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
