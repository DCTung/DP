



initial $monitor("\nSignExtension toExtend: %h signExtend: %h\nALUControl funct: %h ALUop: %h  operation: %h",
IFID.instruc_out, signExtended, IDEX.funct_code_out, IDEX.ALUOP_out, operation);
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

//ForwardingUnit FU(.EM_RD(EXMem.op1), .MWB_RD(Mwb.ReadData), .ID_OP1(IDEX.RD1), .ID_OP2(IDEX.RD2), .EM_RegWrite(EXMem.MemtoReg_out), .MWB_RegWrite(Mwb.RegWrite_out), .ForwardA(ForwardA) ,.ForwardB(ForwardB));


//MWBBuffer      Mwb(.MemToReg_in(EXMem.MemtoReg_out), .RegWrite_in(EXMem.RegWrite_out), .ALU_Result(EXMBuffer.ALU_Result_out), .ReadData(m1.data_out), .movOP_in(EXMem.movOp_out), .MemToReg_out(MemToReg_out), .RegWrite_out(RegWrite_out), .ALU_Result_out(ALU_Result_out), .ReadData_out(ReadData_out), .movOP_out(movOp_out));

//(.operation(ac1.operation), .op1(IDEX.RD1_out), .op2(IDEX.RD2_out), .result(result), .remainder(remainder), .o(o));

//mem		m1(.clk(clk), .reset(reset), .MemWrite(EXMem.MemWrite_out), .MemRead(EXMem.MemRead_out), .Memaddr_in(EXMem.ALU_Result_out), .data_in(EXMem.op1_out), .data_out(data_out));
