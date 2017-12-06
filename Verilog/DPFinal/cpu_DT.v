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
`include "shiftLeft.v"
`include "WBMux.v"

/*
mux include
`include "MUX_aluop2.v"
`include "MUX_FA.v"
`include "MUX_FB.v"

`include "mux2to1.v" COVERED BY MUXPC
`include "muxPC.v"
*/

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
wire [3:0] IFID_Fop1, IFID_Fop2;

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


wire R15_out, ALUSrc_out, MemToReg_out, RegWrite_out, MemRead_out, MemWrite_out, Branch_out;
wire [1:0] ALUOP_out;
wire [15:0] RD1_out, RD2_out, signExtendedR2_out;
wire [3:0] funct_code_out;
wire [3:0] IFID_RS_OUT, IFID_RT_OUT;

//Sign Extension
wire [15:0] signExtended;

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
//test?


//Forwarding unit
wire [1:0] ForwardA, ForwardB;

//HazardDetection
wire STALL,PCWrite,IFID_Write;

//branch stuff
wire PCSRC;
wire [15:0] shiftedOut;
wire [15:0] BL_result;

//muxStuff

			//muxPC				PCMUX(.PCAdderAddr(add.addr_out), .BranchAddr(BLadder.BL_result), .PCSRC(HD.PCWrite),.muxPCOut(muxPCOut));
			adder         add1(.clk(clk), .reset(reset), .addr_in(pc1.addr_out), .constant(constant), .addr_out(addr_out));
			PC             pc1(.addr_in(add1.addr_out), .addr_out(addr_out));
			IM             im1(.reset(reset), .addr_in(pc1.addr_out), .addr_out(addr_out), .instruc_out(instruc_out));
			IFID_buffer   IFID(.instruc_in(im1.instruc_out), .addr_in(im1.addr_out),.instruc_out(instruc_out), .opcode(opcode), .funct(funct), .addr_out(addr_out), .offset(offset), .IFID_Fop1(IFID_Fop1), .IFID_Fop2(IFID_Fop2));

			control 	c1(.clk(clk), .reset(reset), .con_opcode(IFID.opcode), .R15(R15), .ALUSrc(ALUSrc), .MemToReg(MemToReg), .RegWrite(RegWrite), .MemRead(MemRead), .MemWrite(MemWrite), .Branch(Branch), .ALUOP(ALUOP));

			RegFile		r1(.instruc_in(IFID.instruc_out), .Writedata(WBmux.WriteData), .Writereg(Writereg), .RegWrite(c1.RegWrite), .reset(reset), .op1(op1), .op2(op2), .Reg15(Reg15));

			SignExtension signExtend(.toExtend(IFID.IFID_Fop2), .signExtended(signExtended));

			IDEXBuffer    IDEX(.IDEX_FLUSH(IDEX_FLUSH), .RD1(r1.op1), .RD2(r1.op2), .signExtendedR2(signExtend.signExtended), .funct_code_in(IFID.funct), .IFID_RS(IFID.IFID_Fop1), .IFID_RT(IFID.IFID_Fop2), .R15_in(c1.R15), .ALUSrc_in(c1.ALUSrc), .MemToReg_in(c1.MemToReg), .RegWrite_in(c1.RegWrite), .MemRead_in(c1.MemRead), .MemWrite_in(c1.MemWrite), .Branch_in(c1.Branch), .ALUOP_in(c1.ALUOP), .R15_out(R15_out), .ALUSrc_out(ALUSrc_out), .MemToReg_out(MemToReg_out), .RegWrite_out(RegWrite_out), .MemRead_out(MemRead_out), .MemWrite_out(MemWrite_out), .Branch_out(Branch_out), .ALUOP_out(ALUOP_out), .RD1_out(RD1_out), .RD2_out(RD2_out), .signExtendedR2_out(signExtendedR2_out), .funct_code_out(funct_code_out), .IFID_RS_OUT(IFID_RS_OUT), .IFID_RT_OUT(IFID_RT_OUT), .opcode(IFID.opcode), .opcode_out(opcode), .addr_in(IFID.addr_out), .addr_out(addr_out));
			//ForwardingUnit FwdU(.EM_RD(EXMem.EXM_RegRD_out), MWB_RD(Mwb.))
			//MUX_FA			muxFA(.Forward())
			ALUcontrol     ac1(.clk(clk), .reset(reset), .funct(IDEX.funct_code_out), .ALUop(IDEX.ALUOP_out), .operation(operation));

			ALU		a1(.operation(ac1.operation), .op1(IDEX.RD1_out), .op2(IDEX.RD2_out), .result(result), .remainder(remainder), .o(o));
			EXMBuffer    EXMem( .ALU_Result(a1.result), .ALU_Remainder(a1.remainder), .movOP_in(IDEX.IFID_RT_OUT), .MemtoReg_in(IDEX.MemToReg_out), .MemWrite_in(IDEX.MemWrite_out), .MemRead_in(IDEX.MemRead_out), .R15_in(IDEX.R15_out), .FLUSH_EX(IDEX_FLUSH), .RegWrite(IDEX.RegWrite_out), .IDEX_RegRD(IDEX.IFID_RS_OUT),.IDEX_RegRT(IDEX.IFID_RT_OUT), .MemtoReg_out(MemToReg_out), .MemWrite_out(MemWrite_out), .MemRead_out(MemRead_out), .R15_out(R15_out), .RegWrite_out(RegWrite_out), .ALU_Result_out(ALU_Result_out), .ALU_Remainder_out(ALU_Remainder_out), .movOp_out(movOp_out), .EXM_RegRD_out(EXM_RegRD_out), .EXM_RegRT_out(EXM_RegRT_out));

			mem		m1(.clk(clk), .reset(reset), .MemWrite(EXMem.MemWrite_out), .MemRead(EXMem.MemRead_out), .Memaddr_in(EXMem.EXM_RegRD_out), .data_in(EXMem.ALU_Result_out), .data_out(data_out));

			MWBBuffer      Mwb(.MemToReg_in(EXMem.MemtoReg_out), .RegWrite_in(EXMem.RegWrite_out), .ALU_Result(EXMBuffer.ALU_Result_out), .ReadData(m1.data_out), .movOP_in(EXMem.movOp_out), .MemToReg_out(MemToReg_out), .RegWrite_out(RegWrite_out), .ALU_Result_out(ALU_Result_out), .ReadData_out(ReadData_out), .movOP_out(movOp_out));
			WBMux    WBmux( .MemToReg(Mwb.MemToReg_out), .ALUResult(Mwb.ALU_Result_out), .MReadData(Mwb.ReadData_out), .WriteData(Writedata));
			/*ForwardingUnit FU(.EM_RD(EXMem.op1), .MWB_RD(Mwb.ReadData), .ID_OP1(IDEX.RD1), .ID_OP2(IDEX.RD2), .EM_RegWrite(EXMem.MemtoReg_out), .MWB_RegWrite(Mwb.RegWrite_out), .ForwardA(ForwardA) ,.ForwardB(ForwardB));

			//need to parse IDEX so that comparing registers atm RD1_out and RD2_out is full instrc
			HazardDetection HD(.IFID_op1(IFID.rd1), .IFID_op2(IFID.rd2), .IDEX_op1(IDEX.RD1_out), .IDEX_MemRead(IDEX.MemRead_out), .rst(reset), .STALL(STALL), .PCWrite(PCWrite), .IFID_Write(IFID_Write));


			branchLogic BL(.rd1(a1.op1),.rd15(a1.remainder),.branch(IDEX.Branch_out), .PCSRC(PCSRC),.opcode(IDEX.opcode));
			shiftLeft SL(.signExtendedR2(IDEX.signExtendedR2_out),.shiftedOut(shiftedOut));
			//need to edit buffer to pass clean addr
			//need IFID to pass pcADDR to IDEX
			BL_add BLadder(.SE(SL.signExtendedR2), .PC_in(IDEX.addr_out), .BL_result(BL_result));
			//branch logic
			//rd15 from buff and rd1 from buff?
			//BranchLogic BL_AndGate(.rd1(IDEX
*/
			initial
			$monitor("PC: reset = %b, addr_in = %h, addr_out = %h \nADDER: addr_in = %h, constant = %h, addr_out = %h,\nIM: Addr_in = %h, Addr_out = %h, instruc_out = %h \nIFIDBUFFER: instruc_in = %h, addr_in = %h, ,instruc_out = %h, opcode = %b, funct= %b, addr_out = %h, offset = %b , IFID_Fop1 = %b,IFID_Fop2 = %b \nControl: control = %b, R15 = %h,ALUSrc= %b,MemToReg = %b,RegWrite = %b,MemRead = %b,MemWrite = %b, Branch = %b, ALUOP = %b \nRegFile:  Instruc_in = %h, Writedata = %b Writereg =%b RegWrite = %b reset = %b op1 = %h op2 = %h Reg15 = %h\nIDEX:IDEX_FLUSH =%b, RD1 = %h,RD2 = %h, signExtendedR2 = %b, funct_code_in =%b, IFID_RS = %h, IFID_RT =%h , R15_in = %h, ALUSrc_in = %b, MemToReg_in =%b, RegWrite_in= %b, MemRead_in = %b, MemWrite_in = %b,Branch_in = %b, ALUOP_in =%b,R15_out =%b,ALUSrc_out = %b ,MemToReg_out =%b,RegWrite_out = %b,MemRead_out =%b, MemWrite_out =%b , Branch_out =%b,ALUOP_out = %b, RD1_out = %h, RD2_out =%h, signExtendedR2_out =%b, funct_code_out =%b, IFID_RS_OUT =%h, IFID_RT_OUT = %h, opcode = %b, opcode_out = %b, addr_in = %h, addr_out =%h \nSignExtension toExtend: %b signExtend: %b\nALUControl funct: %b ALUop: %b  operation: %b\n LOOK AT ME Pplase ALU operation: %b op1: %h op2: %h result: %h remainder: %h overflow:%b \nEXMBuffer: ALU_Result = %h, ALU_Remainder= %h, movOP_in= %b , MemtoReg_in = %b,MemWrite_in =%b, MemRead_in = %b, R15_in =%b,FLUSH_EX =%b, RegWrite =%b, IDEX_RegRD =%b, ,MemtoReg_out = %b, MemWrite_out = %b, MemRead_out =%b, R15_out =%b,RegWrite_out =%b, ALU_Result_out =%b, ALU_Remainder_out = %h, movOp_out =%b,EXM_RegRD_out = %b\nMEM: MemWrite: %b MemRead: %b MemAddr_in %h data_in: %h data_out:%h \nMWBBuffer: MemToReg_in: %b RegWrite_in: %b ALU_Result: %h ReadData: %h movOP_in: %h MemToReg_out: %b RegWriteOut: %b ALU_Result_out: %b ReadData_out: %b movOP_out %h \n WBMUX: MemToReg =%b, ALUResult = %h, MReadData = %h, WriteData = %h",
			reset, pc1.addr_in, pc1.addr_out,
			add1.addr_in, add1.constant, add1.addr_out,
			pc1.addr_out, addr_out, instruc_out,
			 im1.instruc_out, im1.addr_out, instruc_out, opcode, funct, addr_out, offset, IFID_Fop1, IFID_Fop2,
			 IFID.opcode, R15,ALUSrc,MemToReg,RegWrite,MemRead,MemWrite,Branch, ALUOP,
			 IFID.instruc_out, Writedata, Writereg, c1.RegWrite, reset, op1, op2, Reg15,
			IDEX_FLUSH,r1.op1,r1.op2,signExtend.signExtended,IFID.funct,IFID.IFID_Fop1, IFID.IFID_Fop2, c1.R15,c1.ALUSrc,c1.MemToReg,c1.RegWrite,c1.MemRead,c1.MemWrite,c1.Branch,c1.ALUOP,R15_out,ALUSrc_out, MemToReg_out, RegWrite_out, MemRead_out,MemWrite_out,Branch_out,ALUOP_out,RD1_out,RD2_out,signExtendedR2_out,funct_code_out,IFID_RS_OUT,IFID_RT_OUT,IFID.opcode,opcode, IFID.addr_out,addr_out,
			IFID.IFID_Fop2, signExtended,
			IDEX.funct_code_out, IDEX.ALUOP_out, operation,//look at me too
			ac1.operation, IDEX.RD1_out, IDEX.RD2_out, result, remainder, o,
			IDEX.RD1_out, a1.result,a1.remainder,movOP_in,IDEX.MemToReg_out,IDEX.MemWrite_out,IDEX.MemRead_out,IDEX.R15_out,IDEX_FLUSH,IDEX.RegWrite_out,IDEX_RegRD,MemToReg_out,MemWrite_out,MemRead_out,R15_out, RegWrite_out, ALU_Result_out,ALU_Remainder_out,movOp_out,EXM_RegRD_out,
			EXMem.MemWrite_out, EXMem.MemRead_out, EXMem.ALU_Result_out, EXMem.ALU_Result_out, data_out,
			EXMem.MemtoReg_out, EXMem.RegWrite_out,EXMBuffer.ALU_Result_out,m1.data_out, ALU_Result_out,MemToReg_out, RegWrite_out,ALU_Result_out, ReadData_out, movOp_out,
			Mwb.MemToReg_out,Mwb.ALU_Result_out,Mwb.ReadData_out,Writedata);

			//IM             im1(.reset(reset), .addr_in(pc1.addr_out), .addr_out(addr_out), .instruc_out(instruc_out));
			//IFID_buffer   IFID(.instruc_in(im1.instruc_out), .addr_in(im1.addr_out),.instruc_out(instruc_out), .opcode(opcode), .funct(funct), .addr_out(addr_out), .offset(offset),.IFID_Fop1(IFID_Fop1), .IFID_Fop2(IFID_Fop2));
			//control 	c1(.clk(clk), .reset(reset), .con_opcode(IFID.opcode), .R15(R15), .ALUSrc(ALUSrc), .MemToReg(MemToReg), .RegWrite(RegWrite), .MemRead(MemRead), .MemWrite(MemWrite), .Branch(Branch), .ALUOP(ALUOP));
			//RegFile		r1(.instruc_in(IFID.instruc_out), .Writedata(Writedata), .Writereg(Writereg), .RegWrite(c1.RegWrite), .reset(reset), .op1(op1), .op2(op2), .Reg15(Reg15));
			//SignExtension signExtend(.toExtend(IFID.IFID_Fop2), .signExtended(signExtended));
			//IDEXBuffer    IDEX(.IDEX_FLUSH(IDEX_FLUSH), .RD1(r1.op1), .RD2(r1.op2), .signExtendedR2(signExtend.signExtended), .funct_code_in(IFID.funct), .IFID_RS(IFID_RS), .IFID_RT(IFID.IFID_Fop2), .R15_in(c1.R15), .ALUSrc_in(c1.ALUSrc), .MemToReg_in(c1.MemToReg), .RegWrite_in(c1.RegWrite), .MemRead_in(c1.MemRead), .MemWrite_in(c1.MemWrite), .Branch_in(c1.Branch), .ALUOP_in(c1.ALUOP), .R15_out(R15_out), .ALUSrc_out(ALUSrc_out), .MemToReg_out(MemToReg_out), .RegWrite_out(RegWrite_out), .MemRead_out(MemRead_out), .MemWrite_out(MemWrite_out), .Branch_out(Branch_out), .ALUOP_out(ALUOP_out), .RD1_out(RD1_out), .RD2_out(RD2_out), .signExtendedR2_out(signExtendedR2_out), .funct_code_out(funct_code_out), .IFID_RS_OUT(IFID_RS_OUT), .IFID_RT_OUT(IFID_RT_OUT), .opcode(IFID.opcode), .opcode_out(opcode), .addr_in(IFID.addr_out), .addr_out(addr_out));
			//ALUcontrol     ac1(.clk(clk), .reset(reset), .funct(IDEX.funct_code_out), .ALUop(IDEX.ALUOP_out), .operation(operation));
      //ALU		a1(.operation(ac1.operation), .op1(IDEX.RD1_out), .op2(IDEX.RD2_out), .result(result), .remainder(remainder), .o(o));
		//EXMBuffer    EXMem(.op1(IDEX.RD1_out), .ALU_Result(a1.result), .ALU_Remainder(a1.remainder), .movOP_in(movOP_in), .MemtoReg_in(IDEX.MemToReg_out), .MemWrite_in(IDEX.MemWrite_out), .MemRead_in(IDEX.MemRead_out), .R15_in(IDEX.R15_out), .FLUSH_EX(IDEX_FLUSH), .RegWrite(IDEX.RegWrite_out), .IDEX_RegRD(IDEX_RegRD), .op1_out(op1_out), .MemtoReg_out(MemToReg_out), .MemWrite_out(MemWrite_out), .MemRead_out(MemRead_out), .R15_out(R15_out), .RegWrite_out(RegWrite_out), .ALU_Result_out(ALU_Results_out), .ALU_Remainder_out(ALU_Remainder_out), .movOp_out(movOp_out), .EXM_RegRD_out(EXM_RegRD_out));
		//mem		m1(.clk(clk), .reset(reset), .MemWrite(EXMem.MemWrite_out), .MemRead(EXMem.MemRead_out), .Memaddr_in(EXMem.ALU_Result_out), .data_in(EXMem.ALU_Result_out), .data_out(data_out));
		//MWBBuffer      Mwb(.MemToReg_in(EXMem.MemtoReg_out), .RegWrite_in(EXMem.RegWrite_out), .ALU_Result(EXMBuffer.ALU_Result_out), .ReadData(m1.data_out), .movOP_in(EXMem.movOp_out), .MemToReg_out(MemToReg_out), .RegWrite_out(RegWrite_out), .ALU_Result_out(ALU_Result_out), .ReadData_out(ReadData_out), .movOP_out(movOp_out));
		//			WBMux    WBmux( .MemToReg(Mwb.MemToReg_out), .ALUResult(Mwb.ALU_Result_out), .MReadData(Mwb.ReadData_out), .WriteData(Writedata));
endmodule

/*
Staging

Stage1





*/
