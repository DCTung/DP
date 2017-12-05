module PC (
	    input [7:0] addr_in, 
	    output reg [7:0] addr_out);

always@(*)
	begin
			addr_out = addr_in;
	end
endmodule
