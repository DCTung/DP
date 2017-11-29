module IFID_buffer(
input clk,reset,  
input [15:0] instruc_in, 
input [7:0] addr_in, 
output reg [15:0] instruc_out,
output reg [3:0] opcode,
output reg [7:0] addr_out);

always@(posedge clk or negedge reset)
	begin
		if(reset)
		begin
			instruc_out <= 16'h0000;
			addr_out <= 8'h00;
			opcode <= 4'h0;
		end

		else
		begin
			instruc_out <= instruc_in;
			addr_out <= addr_in;
			opcode <= instuct_in[15:12];
		end
	end
endmodule
