module MUX_aluop2(
  input [15:0] SE, FB_MUX_Result,
  input [3:0] opcode,
  output reg mux_ALUOP2_out
  );

  always@(*)
    if (opcode == 4'b1010 || opcode == 4'b1011 || opcode == 4'b1100 || opcode == 4'b1101)
      mux_ALUOP2_out = SE;
    else
      mux_ALUOP2_out = FB_MUX_Result;
endmodule
