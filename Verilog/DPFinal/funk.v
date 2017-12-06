
muxPC
"PCAdderAddr: %h BranchAddr: %h PCSRC: %b  muxPCOUT: %h"
add.addr_out, BLadder.BL_result, HD.PCWrite, muxPCOut
//muxPC				PCMUX(.PCAdderAddr(add.addr_out), .BranchAddr(BLadder.BL_result), .PCSRC(HD.PCWrite),.muxPCOut(muxPCOut));



//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ IDK WHAT U NEED FORM HERE
initial $monitor("\nSignExtension toExtend: %h signExtend: %h\nALUControl funct: %h ALUop: %h  operation: %h",
IFID.instruc_out, signExtended, IDEX.funct_code_out, IDEX.ALUOP_out, operation
//SignExtension signExtend(.toExtend(IFID.instruc_out), .signExtended(signExtended));

//ALUcontrol     ac1(.clk(clk), .reset(reset), .funct(IDEX.funct_code_out), .ALUop(IDEX.ALUOP_out), .operation(operation));

ALU
"ALU operation: %h op1: %h op2: %h result: %h remainder: %h o:%h"
ac1.operation, IDEX.RD1_out, IDEX.RD2_out, result, remainder, o


MEM
"Mem MemWrite: %b MemRead: %b MemAddr_in %h data_in: %h data_out:%h"
EXMem.MemWrite_out, EXMem.MemRead_out, EXMem.ALU_Result_out, EXMem.op1_out, data_out


MWBBuffer
"MWBBuffer MemToReg_in: %b RegWrite_in: %b ALU_Result: %h ReadData: %h movOP_in: %h MemToReg_out: %b RegWriteOut: %b ALU_Result_out: %b ReadData_out: %b movOP_out %h"
EXMem.MemtoReg_out, EXMem.RegWrite_out, ALU_Result_out, ReadDate_out, movOp_out

ForwardingUnit
"ForwardingUnit EM_RD: %h MWB_RD: %h ID_OP1: %h ID_OP2: %h EM_RegWrite: %h MWB_RegWrite: %h ForwardA: %b ForwardB: %b"
EXMem.op1, Mwb.ReadDate, IDEX.RD1, IDEX.RD2, EXMem.MemtoReg_out, Mwb.RegWrite_out, ForwardA, ForwardB

HazardDetection
"Hazard Detection: IFID_op1: %h IFID_op2: %h  IDEX_op1: %h IDEX_MemRead: %h STALL: %h  PCWrite: %b  IFID_Write: %b"
IFID.IFID_Fop1, IFID>IFID_Fop2, IDEX.RD1_out, IDEX.MemRead_out, STALL, PCWrite, IFID_Write

BranchLogic
"rd1: %h, rd15: %h, branch: %h, PCSRC: %b, opcode: %h"
a1.op1, a1.remainder, IDEX.Branch_out, PCSRC, IDEX.opcode_out

shiftLeft
"signExtendedR2: %h shiftedOut: %h"
IDEX.signExtendedR2_out, shiftedOut


BLadder
"SE: %h PC_in: %h BL_result: %h"
SL.signExtendedR2, IDEX.addr_out, BL_result
//BL_add BLadder(.SE(SL.signExtendedR2), .PC_in(IDEX.addr_out), .BL_result(BL_result));


//shiftLeft SL(.signExtendedR2(IDEX.signExtendedR2_out),.shiftedOut(shiftedOut));


//branchLogic BL(.rd1(a1.op1),.rd15(a1.remainder),.branch(IDEX.Branch_out), .PCSRC(PCSRC),.opcode(IDEX.opcode));

//HazardDetection HD(.IFID_op1(IFID.IFID_Fop1), .IFID_op2(IFID.IFID_Fop2), .IDEX_op1(IDEX.RD1_out), .IDEX_MemRead(IDEX.MemRead_out), .rst(reset), .STALL(STALL), .PCWrite(PCWrite), .IFID_Write(IFID_Write));


//MWBBuffer      Mwb(.MemToReg_in(EXMem.MemtoReg_out), .RegWrite_in(EXMem.RegWrite_out), .ALU_Result(EXMBuffer.ALU_Result_out), .ReadData(m1.data_out), .movOP_in(EXMem.movOp_out), .MemToReg_out(MemToReg_out), .RegWrite_out(RegWrite_out), .ALU_Result_out(ALU_Result_out), .ReadData_out(ReadData_out), .movOP_out(movOp_out));

//(.operation(ac1.operation), .op1(IDEX.RD1_out), .op2(IDEX.RD2_out), .result(result), .remainder(remainder), .o(o));

//mem		m1(.clk(clk), .reset(reset), .MemWrite(EXMem.MemWrite_out), .MemRead(EXMem.MemRead_out), .Memaddr_in(EXMem.ALU_Result_out), .data_in(EXMem.op1_out), .data_out(data_out));
