`include "RegFile.v"
module RegFile_fixture;
	reg clk, reset, RegWrite;
	reg [15:0] instruc_in, Writedata;
	wire [15:0] op1, op2;
initial
	$monitor ($time, " clk = %b, reset = %b, RegWrite = %b, instruc_in = %h, Writedata = %h, op1 = %h, op2 = %h", clk, reset, RegWrite, instruc_in, Writedata,op1, op2);

RegFile R1(clk, reset, instruc_in, Writedata,RegWrite, op1, op2);

initial
	begin 
		clk = 1'b1;
		forever #10 clk = ~clk;
	end
initial
	begin
		reset = 1;
		#20	reset = 0; instruc_in = 16'hF120; RegWrite = 1'b1; Writedata = 16'hFFFF;
		#20
		reset = 1;
	end
initial
	begin
		#60 $finish;
	end
endmodule
