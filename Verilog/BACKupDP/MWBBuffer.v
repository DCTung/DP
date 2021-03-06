module MWBBuffer(
  input MemToReg_in, RegWrite_in,
  input [15:0] ALU_Result,
  input [15:0] ReadData,
  input [3:0] movOP_in,
  //remainder?

  //forwarding
  input [3:0] EXM_RS, EXM_RT,
  output reg [3:0] MWB_RS, MWB_RT,

  output reg MemToReg_out, RegWrite_out,
  output reg [15:0] ALU_Result_out, ReadData_out,
  output reg [3:0] movOP_out
  //remainder?
  );
  always@(*)
  begin
    MemToReg_out = MemToReg_in;
    RegWrite_out = RegWrite_in;
    ALU_Result_out = ALU_Result;
    movOP_out = movOP_in;
    MWB_RS = EXM_RS;
    MWB_RT = EXM_RT;
  end
endmodule
