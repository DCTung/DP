`include "IFID_buffer.v"
module IFID_buffer_fixture;
//reg clk, reset;
reg [15:0] instruc_in;
reg [7:0] addr_in;
wire [15:0] instruc_out;
wire [3:0] opcode, rd1, rd2;
wire [7:0] addr_out;


	initial $monitor ($time, "  instruc_in = %h, addr_in = %h, instruc_out = %h, opcode = %b, addr_out = %h, rd1 = %h, rd2 = %h", instruc_in, addr_in, instruc_out,opcode, addr_out, rd1, rd2);

	IFID_buffer I1(instruc_in,addr_in, instruc_out, opcode, addr_out, rd1, rd2);

initial
	begin
		#20 instruc_in = 16'hF120; addr_in = 8'h01;
		#20 instruc_in = 16'hDDDD; addr_in = 8'h04;
	end
initial
	begin
		#80 $finish;
	end
endmodule
