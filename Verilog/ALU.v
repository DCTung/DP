module ALU(
  input clk, rst,
  input [3:0] functCode,
  input [3:0] op1, op2,
  output [15:0] remainder,
  output [15:0] ALU_Result,

  //need other condits
  );

  always@(*)
  begin
    case(functCode)


//
