`include "IM.v"
module IM_fixture;
	reg [7:0] addr_in;
	wire [7:0] addr_out;
	wire [15:0] instr;
initial $monitor ($time, " addr_in = %h, addr_out = %h, instr = %h", addr_in,addr_out, instr);
IM I1(addr_in,addr_out, instr);

initial
	begin
	            addr_in = 8'h00;
		#20 addr_in = 8'h02;
		#20 addr_in = 8'h04;
		#20 addr_in = 8'h0A;
		#20 addr_in = 8'h36;
		#20 addr_in = 8'h38;
	end
initial
	begin
		#200 $finish;
	end
endmodule
