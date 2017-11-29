`include "mem.v"
module mem_fixture;
reg clk, reset, MemWrite, MemRead;
reg [7:0] addr_in;
reg [15:0] data_in;
wire [15:0] data_out;

mem m1(clk, reset, MemWrite, MemRead, addr_in, data_in, data_out);
initial $monitor ($time," clk = %b,reset = %b, MemWrite = %b, MemRead = %b, addr_in = %h, data_in = %h, data_out = %h");

initial
	begin
		clk = 1'b0;
		forever #10 clk = !clk;
	end
initial
	begin 
	reset = 1;
	#20 MemRead = 0; MemWrite = 1; addr_in = 8'h10; data_in = 16'h8888;
	#20 MemRead = 1; MemWrite = 0; addr_in = 8'h06; data_in = 16'h1111;
	#20 MemRead = 1; MemWrite = 1; addr_in = 8'h08; data_in = 16'hADAD;
	end
initial
	begin
		#200 $finish;
	end
endmodule
