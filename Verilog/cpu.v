`include "PC.v"
`include "adder.v"
`include "IM.v"
`include "IFID_buffer.v"

module cpu;
//PC signals
reg clk, reset;
reg [7:0] addr_in;
wire [7:0] addr_out;

//adder sigs
reg [7:0] constant;

//IM sigs
wire [15:0] instruc_out;

//IFID_buffer
reg [15:0] instruc_in;
wire [3:0] opcode;

PC             pc1(.clk(clk), .reset(reset), .addr_in(addr_in), .addr_out(addr_out));
adder         add1(.addr_in(PC.addr_out),.constant(constant), .addr_out(addr_out));
IM             im1(.addr_in(PC.addr_out), .addr_out(addr_out), .instruc_out(instruc_out));
IFID_buffer   IFID(.instruc_in(IM.instruc_out), .addr_in(IM.addr_out),.instruc_out(instruc_out), .opcode(opcode), .addr_out(addr_out));

initial	$monitor($time, " PC: reset = %b, addr_in = %h, addr_out = %b \n   adder: addr_in = %h, constant = %h, addr_out = %h, \n   IM: addr_in = %h, addr_out = %h, instruct_out = %h, \n   IFID: instruc_in = %h, addr_in = %h, instruc_out = %h, opcode = %b, addr_out = %h\n", 
reset, addr_in, addr_out,
PC.addr_out, constant, addr_out,
PC.addr_out, addr_out, instruc_out,
IM.instruc_out,IM.addr_out, instruc_out, opcode, addr_out);
initial
begin
	clk = 1'b1;
	forever #10 clk = !clk;
end
initial
	begin
				reset = 1;
		#60		reset = 0; addr_in = 8'h00; constant = 8'h02;
		 
	end
initial
	begin
		#200 $finish;
	end
endmodule 
