`include "cpu.v"

module cpu_fixture;
reg clk, reset;

cpu c1 (clk, reset);

initial
	begin	
		clk = 1'b1;
		forever #10 clk = !clk;
	end
initial
	begin
		reset = 1;
		#20 reset = 0; 
		#560 $finish;
	end
endmodule
