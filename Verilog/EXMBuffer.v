module EXMBuffer(
  input [15:0] ALU_Result, ALU_Remainder,
  input [3:0] movOP;

  input MemtoReg_in, MemWrite_in, MemRead_in, R15_in,

  output reg MemtoReg_out, MemWrite_out, MemRead_out, R15_out,
  output reg [15:0] ALU_Result_out, ALU_Remainder_out,
  output reg [3:0] movOp
  );
  //EXBuffer needs? -- Remove zero from output
  //Mem signals (W/R) -- only these from CU?
  //R15 -- ALU RESULT
  //op for MOV like how we saw in class
  //forwarding caught in this tage?

  //WB Signals??? -- RegWrite sig?

  always@(*)

  begin
