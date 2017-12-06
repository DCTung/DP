module muxPC(
  input [8:0] PCAdderAddr, BranchAddr,
  input PCSRC,
  output reg [8:0] muxPCOut
  );

  always@(*)
    if (PCSRC)
      muxPCOut = PCAdderAddr;
    else
      muxPCOut = BranchAddr;
endmodule
