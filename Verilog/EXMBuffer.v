module EXMBuffer(
  input [15:0] op1,
  input [15:0] ALU_Result, ALU_Remainder,
  input [3:0] movOP_in, //not sure about this


  input MemtoReg_in, MemWrite_in, MemRead_in, R15_in, FLUSH_EX, RegWrite,

  //forwarding
  //in <- muxed RT/RD page 311 out are EX/MREGRD
  input [3:0] IDEX_RegRD,
  output reg [15:0] op1_out,
  output reg MemtoReg_out, MemWrite_out, MemRead_out, R15_out, RegWrite_out,
  output reg [15:0] ALU_Result_out, ALU_Remainder_out,
  output reg [3:0] movOp_out,
  output reg [3:0] EXM_RegRD_out
  );
  //EXBuffer needs? -- Remove zero from output
  //Mem signals (W/R) -- only these from CU?
  //R15 -- ALU RESULT
  //op for MOV like how we saw in class
  //forwarding caught in this tage?

  //WB Signals??? -- RegWrite sig?
  //also see 312
  //302

  //book sigs EXMEM passes Regwirte and MemtoReg  also memwrite and mem read
  //pushing branch to stage 3

  always@(*)
  begin
  if(!FLUSH_EX)
    begin
    //Wires
    MemtoReg_out = MemtoReg_in;
    MemWrite_out = MemWrite_in;
    MemRead_out = MemRead_in;
    R15_out = R15_in;
    RegWrite_out = RegWrite;

    ALU_Result_out = ALU_Result;
    ALU_Remainder_out = ALU_Remainder_out;
    movOp_out = movOP_in;
    EXM_RegRD_out = IDEX_RegRD;
    op1_out = op1;
    end
  else
    begin
    MemtoReg_out = 0;
    MemWrite_out = 0;
    MemRead_out = 0;
    R15_out = 0;
    RegWrite_out = 0;

    ALU_Result_out = 0;
    ALU_Remainder_out = 0;
    movOp_out = 0;
    EXM_RegRD_out = 0;
    op1_out = 16'h00;
    end
end
endmodule
