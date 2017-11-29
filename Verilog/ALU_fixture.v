`include "ALU.v"

module ALU_fixture;

reg clk, rst;
reg [3:0] functCode;
reg signed [15:0] op1, op2;
wire [15:0] result, remainder;
wire o;

initial
  $monitor( $time, "Function Code: %4b op1: %h op2: %h \n result: %h remainder: %h, Overflow: %b",
  functCode,op1,op2, result, remainder, o);

ALU ALUH(clk, rst, functCode, op1, op2, result, remainder, o);


initial
	begin
		clk = 1'b0;
		forever #10  clk = ~clk;
	end

initial
	begin
		rst = 1;
		#20 rst = 0; //addie test
    functCode = 4'b0000;
    op1 = 16'h1111;
    op2 = 16'h8888;
		#20
		rst = 1;
    #20
    rst =0;
    //mult test
    functCode = 4'b0100;
    op1 = 16'h1;
    op2 = 16'h1;
    #20
    rst = 1;
	end
initial
	begin
		#80 $finish;
	end
endmodule

/*

module ALU(
  input clk, rst,
  input [3:0] functCode,
  input signed [15:0] op1, op2,
  output reg signed [15:0] result,
  output reg [15:0] remainder,
  output reg o
  //need other condits
  );

  always@(*)
  begin
    case(functCode)
      4'b0000: //addies
        result = op1 + op2;
        //need overflow detection for each @@@@

      4'b0001: //subbies
        result = op1 - op2;

      4'b0100: //multiplic
      begin
        result = op1 * op2;
        remainder = op1%op2;
      end
      4'b0101: //divvies
      begin
        result = op1/op2;
        remainder = op1%op2;
      end
      4'b0111: //move
        result = op1 + 0;

      4'b1000: //swappies
        result = op1;
        //op2 straight to buff?
      endcase
    end
  endmodule

*/
