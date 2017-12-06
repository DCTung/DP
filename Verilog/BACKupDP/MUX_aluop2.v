module MUX_aluop2(
  input [15:0] SE, FB_MUX_Result,
  input ALUSRC,
  output reg [15:0] mux_ALUOP2_out
  );

  always@(*)
    if (ALUSRC)
      mux_ALUOP2_out = SE;
    else
      mux_ALUOP2_out = FB_MUX_Result;
endmodule