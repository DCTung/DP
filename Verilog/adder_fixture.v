`include "adder.v"
module adder_fixture;
reg [7:0] addr_in;
reg [3:0] constant;
wire [7:0] addr_out;

initial 
	$monitor($time, " addr_in = %h, constant = %d, addr_out = %h", addr_in, constant, addr_out);
adder a1(addr_in, constant, addr_out);

initial
	begin
		addr_in = 8'h00; constant = 4'b0010;
	#10	addr_in = 8'h02;
	#10	addr_in	= 8'h04;
	end
initial
	begin
		#30 $finish;
	end
endmodule 
