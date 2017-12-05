module mux2to1(input select, input [7:0] nojump_addr, jump_addr, output reg [7:0] addr_out);
always@(*)
	begin
		if(!select)
			addr_out = nojump_addr;
		else 
			addr_out = jump_addr;
	end
endmodule
