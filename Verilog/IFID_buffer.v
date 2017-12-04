module IFID_buffer( 
input [15:0] instruc_in, 
input [7:0] addr_in, 
output reg [15:0] instruc_out,
output reg [3:0] opcode, funct,
output reg [7:0] addr_out,
output reg [11:0] offset);

always@(*)
	begin
			instruc_out = instruc_in;
			addr_out = addr_in;
			opcode = instruc_in[15:12];
			funct = instruc_in[3:0]; //type A(funct)
			offset = instruc_in[11:0]; // Type B(4bit) Type C(8bit) Type D(12bit) 
			
	end
endmodule
