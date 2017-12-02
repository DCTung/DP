`include "PC.v"
`include "adder.v"
`include "IM.v"
`include "IFID_buffer.v"
`include "control.v"
`include "RegFile.v"

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
reg[3:0] con_opcode;
wire R15, ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, Branch;
wire[1:0] ALUOP;

//RegFile
reg [15:0] Writedata;
reg [3:0] Writereg;
wire [15:0] op1, op2, Reg15;

			adder         add1(.clk(clk), .reset(reset), .addr_in(addr_out), .constant(constant), .addr_out(addr_out));
			PC             pc1( .addr_in(add1.addr_out), .addr_out(addr_out));
			IM             im1(.reset(reset), .addr_in(pc1.addr_out), .addr_out(addr_out), .instruc_out(instruc_out));
			IFID_buffer   IFID(.instruc_in(im1.instruc_out), .addr_in(im1.addr_out),.instruc_out(instruc_out), .opcode(opcode), .funct(funct), .addr_out(addr_out), .offset(offset));
			control 	c1(.clk(clk), .reset(reset), .con_opcode(IFID.opcode), .R15(R15), .ALUSrc(ALUSrc), .MemToReg(MemToReg), .RegWrite(RegWrite), .MemRead(MemRead), .MemWrite(MemWrite), .Branch(Branch), .ALUOP(ALUOP));
			RegFile		r1(.instruc_in(IFID.instruc_out), .Writedata(Writedata), .Writereg(Writereg), .RegWrite(c1.RegWrite), .reset(reset), .op1(op1), .op2(op2), .Reg15(Reg15));
initial	$monitor(" \n    PC: reset = %b, addr_in = %h, addr_out = %h \n   ADDER: addr_in = %h, constant = %h, addr_out = %h, \n   IM: addr_in = %h, addr_out = %h, instruct_out = %h, \n   IFID: instruc_in = %h, addr_in = %h, instruc_out = %h, opcode = %b, funct = %b, addr_out = %h, offset = %b\n   CONTROL: opcode = %b, R15 = %b, ALUSrc = %b, MemtoReg = %b, RegWrite = %b, MemRead = %b, MemWrite = %b, Branch = %b, ALUOP = %b\n   REGFILE: instruc_in = %h, WriteData = %h, WriteReg = %d, RegWrite = %b, op1 = %h, op2 = %h, Reg15 = %h", 
reset, addr_in, addr_out,
pc1.addr_out, add1.constant, addr_out,
pc1.addr_out, addr_out, instruc_out,
im1.instruc_out, im1.addr_out, instruc_out, opcode, funct, addr_out, offset,
IFID.opcode, R15, ALUSrc, MemToReg, RegWrite, MemRead,MemWrite, Branch, ALUOP,
IFID.instruc_out, Writedata, Writereg, c1.RegWrite, op1, op2, Reg15);

endmodule 
