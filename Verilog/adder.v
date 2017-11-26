module adder(input[7:0] addr_in, input [3:0] constant, output [7:0] addr_out);
	assign addr_out = addr_in + constant;
endmodule
