module IFID_buffer( 
input [15:0] instruc_in, 
input [7:0] addr_in, 
output reg [15:0] instruc_out,
output reg [3:0] opcode,
output reg [7:0] addr_out);

always@(*)
	begin
		instruc_out = instruc_in;
		addr_out = addr_in;
		opcode = instruc_in[15:12];
	end
endmodule
