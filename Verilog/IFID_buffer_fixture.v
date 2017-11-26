`include "IFID_buffer.v"
module IFID_buffer_fixture;
reg clk, reset;
reg [15:0] instruc_in;
reg [7:0] addr_in;
wire [15:0] instruc_out;
wire [7:0] addr_out;


initial $monitor ($time, " clk = %b, reset = %b, instruc_in = %h, addr_in = %h, instruc_out = %h, addr_out = %h", clk, reset, instruc_in, addr_in, instruc_out, addr_out);

IFID_buffer I1(clk,reset,instruc_in,addr_in, instruc_out, addr_out);


initial
	begin
		clk = 1'b0;
		forever #10  clk = ~clk;
	end

initial
	begin
		reset = 1;
		#20 reset = 0; instruc_in = 16'hF120; addr_in = 8'h01;
		#20
		reset = 1;
	end
initial
	begin
		#80 $finish;
	end
endmodule
