module PC (
	    input clk,reset, 
	    input [7:0] addr_in, 
	    output reg [7:0] addr_out);

always@(posedge clk or negedge reset)
	begin
		if(reset)
			addr_out <= 2'h00;
		else 
			addr_out <= addr_in;
	end
endmodule
