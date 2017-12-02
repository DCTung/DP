`include "PC.v"
`include "adder.v"
`include "IM.v"
`include "IFID_buffer.v"
//'include "control.v"

module cpu(input clk, reset);
//PC signals
reg [7:0] addr_in = 8'h00;
wire [7:0] addr_out;

//adder sigs
reg [7:0] constant = 8'h02;

//IM sigs
wire [15:0] instruc_out;

//IFID_buffer
reg [15:0] instruc_in;
wire [3:0] opcode, funct;
wire [11:0] offset;

//control
//reg[3:0] opcode;
//wire R15, ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, Branch;
//wire[1:0] ALUOP;

			adder         add1(.clk(clk), .reset(reset), .addr_in(addr_out), .constant(constant), .addr_out(addr_out));
			PC             pc1( .addr_in(add1.addr_out), .addr_out(addr_out));
			IM             im1(.reset(reset), .addr_in(pc1.addr_out), .addr_out(addr_out), .instruc_out(instruc_out));
			IFID_buffer   IFID(.instruc_in(im1.instruc_out), .addr_in(im1.addr_out),.instruc_out(instruc_out), .opcode(opcode), .funct(funct), .addr_out(addr_out), .offset(offset));

initial	$monitor(" \n PC: reset = %b, addr_in = %h, addr_out = %h \n   adder: addr_in = %h, constant = %h, addr_out = %h, \n   IM: addr_in = %h, addr_out = %h, instruct_out = %h, \n   IFID: instruc_in = %h, addr_in = %h, instruc_out = %h, opcode = %b, funct = %b, addr_out = %h, offset = %b\n", 
reset, addr_in, addr_out,
PC.addr_out, add1.constant, addr_out,
PC.addr_out, addr_out, instruc_out,
IM.instruc_out,IM.addr_out, instruc_out, opcode, funct, addr_out, offset);

endmodule 
