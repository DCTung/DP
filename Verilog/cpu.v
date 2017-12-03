`include "PC.v"
`include "adder.v"
`include "IM.v"
`include "IFID_buffer.v"
`include "control.v"
`include "RegFile.v"
`include "IDEXBuffer.v"

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

//IDEX_buffer
reg IDEX_FLUSH;
reg [15:0] signExtendedR2;
reg [15:0] IFID_RS, IFID_RT;
wire R15_out, ALUSrc_out, MemToReg_out, RegWrite_out, MeRead_out, MemWrite_out, Branch_out;
wire [1:0] ALUOP_out;
wire [15:0] RD1_out, RD2_out, signExtendedR2_out;
wire [3:0] funct_code_out;
wire [15:0] IFID_RS_OUT, IFID_RT_OUT;

			adder         add1(.clk(clk), .reset(reset), .addr_in(addr_out), .constant(constant), .addr_out(addr_out));
			PC             pc1(.addr_in(add1.addr_out), .addr_out(addr_out));
			IM             im1(.reset(reset), .addr_in(pc1.addr_out), .addr_out(addr_out), .instruc_out(instruc_out));
			IFID_buffer   IFID(.instruc_in(im1.instruc_out), .addr_in(im1.addr_out),.instruc_out(instruc_out), .opcode(opcode), .funct(funct), .addr_out(addr_out), .offset(offset));
			control 	c1(.clk(clk), .reset(reset), .con_opcode(IFID.opcode), .R15(R15), .ALUSrc(ALUSrc), .MemToReg(MemToReg), .RegWrite(RegWrite), .MemRead(MemRead), .MemWrite(MemWrite), .Branch(Branch), .ALUOP(ALUOP));
			RegFile		r1(.instruc_in(IFID.instruc_out), .Writedata(Writedata), .Writereg(Writereg), .RegWrite(c1.RegWrite), .reset(reset), .op1(op1), .op2(op2), .Reg15(Reg15));
			IDEXBuffer    IDEX(.IDEX_FLUSH(IDEX_FLUSH), .RD1(r1.op1), .RD2(r1.op2), .signExtendedR2(signExtendedR2), .funct_code_in(IFID.funct), .IFID_RS(IFID_RS), .IFID_RT(IFID_RT), .R15_in(c1.R15), .ALUSrc_in(c1.ALUSrc), .MemToReg_in(c1.MemToReg), .RegWrite_in(c1.RegWrite), .MemRead_in(c1.MemRead), .MemWrite_in(c1.MemWrite), .Branch_in(c1.Branch), .ALUOP_in(c1.ALUOP), .R15_out(R15_out), .ALUSrc_out(ALUSrc_out), .MemToReg_out(MemToReg_out), .RegWrite_out(RegWrite_out), .MemRead_out(MemRead_out), .MemWrite_out(MemWrite_out), .Branch_out(Branch_out), .ALUOP_out(ALUOP_out), .RD1_out(RD1_out), .RD2_out(RD2_out), .signExtendedR2_out(signExtendedR2_out), .funct_code_out(funct_code_out), .IFID_RS_OUT(IFID_RS_OUT), .IFID_RT_OUT(IFID_RT_OUT));

initial	$monitor(" \n    PC: reset = %b, addr_in = %h, addr_out = %h \n   ADDER: addr_in = %h, constant = %h, addr_out = %h, \n   IM: addr_in = %h, addr_out = %h, instruct_out = %h, \n   IFID: instruc_in = %h, addr_in = %h, instruc_out = %h, opcode = %b, funct = %b, addr_out = %h, offset = %b\n   CONTROL: opcode = %b, R15 = %b, ALUSrc = %b, MemtoReg = %b, RegWrite = %b, MemRead = %b, MemWrite = %b, Branch = %b, ALUOP = %b\n   REGFILE: instruc_in = %h, WriteData = %h, WriteReg = %d, RegWrite = %b, op1 = %h, op2 = %h, Reg15 = %h \n   IDEX: IDEX_FLUSH = %b, RD1 = %h, RD2 = %h, signExtendedR2 = %b, funct_code_in = %b, IFID_RS = %h, IFID_RT = %h, R15_in = %b, ALUSrc_in = %b, MemToReg_in = %b, RegWrite_in  = %b, MemRead_in = %b, MemWrite_in = %b, Branch_in = %b, ALUOP_in = %b, R15_out = $b, ALUSrc_out = %b, MemToReg_out = %b, RegWrite_out = %b, MemRead_out = %b, MemWrite_out = %b, Branch_out = %b, ALUOP_out = %b, RD1_out = %h, RD2_out = %h, signExtendedR2_out = %h, funct_code_out = %b, IFID_RS_OUT = %h, IFID_RT_OUT = %h", 
reset, addr_in, addr_out,
pc1.addr_out, add1.constant, addr_out,
pc1.addr_out, addr_out, instruc_out,
im1.instruc_out, im1.addr_out, instruc_out, opcode, funct, addr_out, offset,
IFID.opcode, R15, ALUSrc, MemToReg, RegWrite, MemRead,MemWrite, Branch, ALUOP,
IFID.instruc_out, Writedata, Writereg, c1.RegWrite, op1, op2, Reg15,
IDEX_FLUSH,r1.op1, r1.op2,signExtendedR2,IFID.funct,IFID_RS,IFID_RT,c1.R15,c1.ALUSrc,c1.MemToReg,c1.RegWrite,c1.MemRead,c1.MemWrite,c1.Branch,c1.ALUOP,R15_out,ALUSrc_out,MemToReg_out,RegWrite_out,MemRead_out,MemWrite_out,Branch_out, ALUOP_out,RD1_out,RD2_out,signExtendedR2_out,funct_code_out,IFID_RS_OUT,IFID_RT_OUT);


endmodule 
