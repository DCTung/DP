module adder(
	input clk, reset,
	input[7:0] addr_in, constant, 
	output reg [7:0] addr_out);
always@(posedge clk, negedge reset)
begin
		if(reset)
			addr_out <= 8'h00;
		else 
		addr_out <= addr_in + constant;
end
endmodule
