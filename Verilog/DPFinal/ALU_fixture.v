`include "ALU.v"

module ALU_fixture;

reg clk, rst;
reg [3:0] functCode;
reg signed [15:0] op1, op2;
wire signed [15:0] result, remainder;
wire o;

initial
  $monitor( $time, " Function Code: %4b op1: %h op2: %h \n result: %b remainder: %h, Overflow: %b",
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
		#20 rst = 1;
		#20 rst =0; //mult test
   		    functCode = 4'b0100;
                    op1 = 16'h0001;
                    op2 = 16'h0001;
	end
initial
	begin
		#200 $finish;
	end
endmodule
