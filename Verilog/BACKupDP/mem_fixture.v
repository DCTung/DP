`include "mem.v"
module mem_fixture;
reg clk, reset, MemWrite, MemRead;
reg [15:0] data_in;
wire [15:0] data_out;

mem m1(clk, reset, MemWrite, MemRead, data_in, data_out);
initial $monitor ($time," reset = %b, MemWrite = %b, MemRead = %b, data_in = %h, data_out = %h",reset,MemWrite,MemRead,data_in, data_out);

initial
	begin
		clk = 1'b0;
		forever #10 clk = !clk;
	end
initial
	begin 
	reset = 1;
	#20 reset = 0; MemRead = 0; MemWrite = 1; data_in = 16'h8888;
	#20 MemRead = 1; MemWrite = 0;  data_in = 16'h1111;
	#20 MemRead = 1; MemWrite = 1;  data_in = 16'hADAD;
	#20 MemRead = 1; MemWrite = 0; 
	end
initial
	begin
		#300 $finish;
	end
endmodule
