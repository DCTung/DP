module shiftLeft(
  input [15:0] signExtendedR2,
  output [15:0] shiftedOut
  );
  always@(*)
  begin
  shiftedOut = signExtendedR2 <<1;
  end
  endmodule
