`include "PC.v"
`include "adder.v"
`include "IM.v"
`include "IFID_buffer.v"
`include "SignExtension.v"
`include "control.v"
`include "RegFile.v"
`include "IDEXBuffer.v"
`include "ALU.v"
`include "ALUcontrol.v"
`include "EXMBuffer.v"
`include "mem.v"
`include "MWBBuffer.v"
`include "ForwardingUnit.v"
`include "HazardDetection.v"
`include "mux2to1.v"
`include "muxSelector.v"
`include "BL_add.v"
`include "BranchLogic.v"

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
reg IDEX_FLUSH = 0;
reg [15:0] signExtendedR2;
reg [15:0] IFID_RS, IFID_RT;
wire R15_out, ALUSrc_out, MemToReg_out, RegWrite_out, MemRead_out, MemWrite_out, Branch_out;
wire [1:0] ALUOP_out;
wire [15:0] RD1_out, RD2_out, signExtendedR2_out;
wire [3:0] funct_code_out;
wire [15:0] IFID_RS_OUT, IFID_RT_OUT;

//ALUcontrol
wire [3:0] operation;

//ALU
wire signed [15:0] result;
wire [15:0] remainder;
wire o;

//EXMBuffer
reg movOP_in;
reg [3:0] IDEX_RegRD;
wire [15:0] ALU_Result_out, ALU_Remainder_out;
wire [3:0] movOp_out, EXM_RegRD_out;

//mem
wire [15:0] data_out;

//Mem WB Buffer



//Forwarding unit
wire [1:0] ForwardA, ForwardB;

//HazardDetection
wire STALL,PCWrite,IFID_Write;

//branch stuff
wire PCSRC;
wire [15:0] shiftedOut;
wire [15:0] BL_result;


			adder         add1(.clk(clk), .reset(reset), .addr_in(addr_out), .constant(constant), .addr_out(addr_out));
			PC             pc1(.addr_in(add1.addr_out), .addr_out(addr_out));
			IM             im1(.reset(reset), .addr_in(pc1.addr_out), .addr_out(addr_out), .instruc_out(instruc_out));
			IFID_buffer   IFID(.instruc_in(im1.instruc_out), .addr_in(im1.addr_out),.instruc_out(instruc_out), .opcode(opcode), .funct(funct), .addr_out(addr_out), .offset(offset), .rd1(rd1), .rd2(rd2));
			control 	c1(.clk(clk), .reset(reset), .con_opcode(IFID.opcode), .R15(R15), .ALUSrc(ALUSrc), .MemToReg(MemToReg), .RegWrite(RegWrite), .MemRead(MemRead), .MemWrite(MemWrite), .Branch(Branch), .ALUOP(ALUOP));
			RegFile		r1(.instruc_in(IFID.instruc_out), .Writedata(Writedata), .Writereg(Writereg), .RegWrite(c1.RegWrite), .reset(reset), .op1(op1), .op2(op2), .Reg15(Reg15));

			//dk if we can just grab like this
			SignExtension signExtend(.toExtend(IFID.instruc_out), .signExtended(signExtended));

			IDEXBuffer    IDEX(.IDEX_FLUSH(IDEX_FLUSH), .RD1(r1.op1), .RD2(r1.op2), .signExtendedR2(signExtend.signExtended), .funct_code_in(IFID.funct), .IFID_RS(IFID_RS), .IFID_RT(IFID_RT), .R15_in(c1.R15), .ALUSrc_in(c1.ALUSrc), .MemToReg_in(c1.MemToReg), .RegWrite_in(c1.RegWrite), .MemRead_in(c1.MemRead), .MemWrite_in(c1.MemWrite), .Branch_in(c1.Branch), .ALUOP_in(c1.ALUOP), .R15_out(R15_out), .ALUSrc_out(ALUSrc_out), .MemToReg_out(MemToReg_out), .RegWrite_out(RegWrite_out), .MemRead_out(MemRead_out), .MemWrite_out(MemWrite_out), .Branch_out(Branch_out), .ALUOP_out(ALUOP_out), .RD1_out(RD1_out), .RD2_out(RD2_out), .signExtendedR2_out(signExtendedR2_out), .funct_code_out(funct_code_out), .IFID_RS_OUT(IFID_RS_OUT), .IFID_RT_OUT(IFID_RT_OUT));
			ALUcontrol     ac1(.clk(clk), .reset(reset), .funct(IDEX.funct_code_out), .ALUop(IDEX.ALUOP_out), .operation(operation));
			ALU		a1(.operation(ac1.operation), .op1(IDEX.RD1_out), .op2(IDEX.RD2_out), .result(result), .remainder(remainder), .o(o));
			EXMBuffer    EXMem(.op1(IDEX.RD1_out), .ALU_Result(a1.result), .ALU_Remainder(a1.remainder), .movOP_in(movOP_in), .MemtoReg_in(IDEX.MemToReg_out), .MemWrite_in(IDEX.MemWrite_out), .MemRead_in(IDEX.MemRead_out), .R15_in(IDEX.R15_out), .FLUSH_EX(IDEX_FLUSH), .RegWrite(IDEX.RegWrite_out), .IDEX_RegRD(IDEX_RegRD), .op1_out(op1_out), .MemtoReg_out(MemToReg_out), .MemWrite_out(MemWrite_out), .MemRead_out(MemRead_out), .R15_out(R15_out), .RegWrite_out(RegWrite_out), .ALU_Result_out(ALU_Results_out), .ALU_Remainder_out(ALU_Remainder_out), .movOp_out(movOp_out), .EXM_RegRD_out(EXM_RegRD_out));
			mem		m1(.clk(clk), .reset(reset), .MemWrite(EXMem.MemWrite_out), .MemRead(EXMem.MemRead_out), .Memaddr_in(EXMem.ALU_Result_out), .data_in(EXMem.op1_out), .data_out(data_out));
			MWBBuffer      Mwb(.MemToReg_in(EXMem.MemtoReg_out), .RegWrite_in(EXMem.RegWrite_out), .ALU_Result(EXMBuffer.ALU_Result_out), .ReadData(m1.data_out), .movOP_in(EXMem.movOp_out), .MemToReg_out(MemToReg_out), .RegWrite_out(RegWrite_out), .ALU_Result_out(ALU_Result_out), .ReadData_out(ReadData_out), .movOP_out(movOp_out));
			ForwardingUnit FU(.EM_RD(EXMem.op1), .MWB_RD(Mwb.ReadData), .ID_OP1(IDEX.RD1), .ID_OP2(IDEX.RD2), .EM_RegWrite(EXMem.MemtoReg_out), .MWB_RegWrite(Mwb.RegWrite_out), .ForwardA(ForwardA) ,.ForwardB(ForwardB));


			//need to parse IDEX so that comparing registers atm RD1_out and RD2_out is full instrc
			HazardDetection HD(.IFID_op1(IFID.rd1), .IFID_op2(IFID.rd2), .IDEX_op1(IDEX.RD1_out), .IDEX_MemRead(IDEX.MemRead_out), .rst(reset), .STALL(STALL), .PCWrite(PCWrite), .IFID_Write(IFID_Write));


			branchLogic BL(.rd1(a1.op1),.rd15(a1.remainder),.branch(IDEX.Branch_out), .PCSRC(PCSRC));
			shiftLeft SL(.signExtendedR2(IDEX.signExtendedR2_out),.shiftedOut(shiftedOut));
			//need to edit buffer to pass clean addr
			//need IFID to pass pcADDR to IDEX
			BL_add BLadder(.SE(SL.signExtendedR2), .PC_in(IDEX.addr_out), .BL_result(BL_result);
			//branch logic
			//rd15 from buff and rd1 from buff?
			//BranchLogic BL_AndGate(.rd1(IDEX


initial	$monitor(" \n    PC: reset = %b, addr_in = %h, addr_out = %h \n   ADDER: addr_in = %h, constant = %h, addr_out = %h, \n   IM: addr_in = %h, addr_out = %h, instruct_out = %h, \n   IFID: instruc_in = %h, addr_in = %h, instruc_out = %h, opcode = %b, funct = %b, addr_out = %h, offset = %b\n   CONTROL: opcode = %b, R15 = %b, ALUSrc = %b, MemtoReg = %b, RegWrite = %b, MemRead = %b, MemWrite = %b, Branch = %b, ALUOP = %b\n   REGFILE: instruc_in = %h, WriteData = %h, WriteReg = %d, RegWrite = %b, op1 = %h, op2 = %h, Reg15 = %h \n   IDEX: IDEX_FLUSH = %b, RD1 = %h, RD2 = %h, signExtendedR2 = %b, funct_code_in = %b, IFID_RS = %h, IFID_RT = %h, R15_in = %b, ALUSrc_in = %b, MemToReg_in = %b, RegWrite_in  = %b, MemRead_in = %b, MemWrite_in = %b, Branch_in = %b, ALUOP_in = %b, R15_out = %b, ALUSrc_out = %b, MemToReg_out = %b, RegWrite_out = %b, MemRead_out = %b, MemWrite_out = %b, Branch_out = %b, ALUOP_out = %b, RD1_out = %h, RD2_out = %h, signExtendedR2_out = %h, funct_code_out = %b, IFID_RS_OUT = %h, IFID_RT_OUT = %h \n   ALU: operation = %b, op1 = %h, op2 = %h result = %h remainder = %h o = %b \n   ALUcontrol: funct = %b, ALUop = %b operation = %b \n   EXMem: ALU_Results = %h, ALU_Remainder = %h, movOP_in = %b, MemtoReg_in = %b, MemWrite_in = %b, MemRead_in = %b, R15_in = %b , FLUSH_EX = %b, RegWrite = %b, IDEX_RegRD = %b, MemtoReg_out = %b, MemWrite_out = %b, MemRead_out= %b, R15_out = %b, RegWrite_out = %b , ALU_Result_out = %h, ALU_Remainder_out = %h, movOp_out = %b, EXM_RegRD_out = %b \n   MEM: MemWrite = %b, MemRead= %b, Memaddr_in = %h, data_in = %h, data_out = %h, \n   MemWB: MemToReg_in = %b, RegWrite_in = %b, ALU_Results = %h, ReadData = %h, movOP_in = %b, MemToReg_out = %b, RegWrite_out = %b, ALU_Result_out = %h, ReadData_out = %h, movOp_out = %b, ",
reset, addr_in, addr_out,
pc1.addr_out, add1.constant, addr_out,
pc1.addr_out, addr_out, instruc_out,
im1.instruc_out, im1.addr_out, instruc_out, opcode, funct, addr_out, offset,
IFID.opcode, R15, ALUSrc, MemToReg, RegWrite, MemRead,MemWrite, Branch, ALUOP,
IFID.instruc_out, Writedata, Writereg, c1.RegWrite, op1, op2, Reg15,
IDEX_FLUSH,r1.op1, r1.op2,signExtendedR2,IFID.funct,IFID_RS,IFID_RT,c1.R15,c1.ALUSrc,c1.MemToReg,c1.RegWrite,c1.MemRead,c1.MemWrite,c1.Branch,c1.ALUOP,R15_out,ALUSrc_out,MemToReg_out,RegWrite_out,MemRead_out,MemWrite_out,Branch_out, ALUOP_out,RD1_out,RD2_out,signExtendedR2_out,funct_code_out,IFID_RS_OUT,IFID_RT_OUT,
ac1.operation, IDEX.RD1_out, IDEX.RD2_out, result, remainder, o,
IDEX.funct_code_out, IDEX.ALUOP_out, operation,
a1.result, a1.remainder, movOP_in, IDEX.MemToReg_out,IDEX.MemWrite_out,IDEX.MemRead_out,IDEX.R15_out, IDEX_FLUSH, IDEX.RegWrite_out,IDEX_RegRD,MemToReg_out,MemWrite_out,MemRead_out,R15_out,RegWrite_out,ALU_Results_out,ALU_Remainder_out,movOp_out,EXM_RegRD_out,
EXMem.MemWrite_out, EXMem.MemRead_out, EXMem.ALU_Result_out, EXMem.op1_out, data_out,
EXMem.MemtoReg_out, EXMem.RegWrite_out, EXMBuffer.ALU_Result_out, m1.data_out, EXMem.movOp_out, MemToReg_out, RegWrite_out, ALU_Result_out, ReadData_out, movOp_out);



endmodule

/*
Staging

Stage1





*/
