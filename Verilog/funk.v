



initial $monitor("\nSignExtension toExtend: %h signExtend: %h\nALUControl funct: %h ALUop: %h  operation: %h",
IFID.instruc_out, signExtended, IDEX.funct_code_out, IDEX.ALUOP_out, operation);
//SignExtension signExtend(.toExtend(IFID.instruc_out), .signExtended(signExtended));

//ALUcontrol     ac1(.clk(clk), .reset(reset), .funct(IDEX.funct_code_out), .ALUop(IDEX.ALUOP_out), .operation(operation));

ALU
"ALU operation: %h op1: %h op2: %h result: %h remainder: %h o:%h"
ac1.operation, IDEX.RD1_out, IDEX.RD2_out, result, remainder, o



//(.operation(ac1.operation), .op1(IDEX.RD1_out), .op2(IDEX.RD2_out), .result(result), .remainder(remainder), .o(o));
