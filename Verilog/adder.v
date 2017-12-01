module adder(
	input[7:0] addr_in, constant, 
	output reg [7:0] addr_out);
always@(*)
	begin
	addr_out = addr_in + constant;
	end
endmodule
