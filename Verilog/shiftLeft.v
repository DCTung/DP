module shiftLeft(
  input [15:0] signExtendedR2,
  output [15:0] shiftedOut
  );

  shiftedOut = signExtendedR2 <<1;
  endmodule
