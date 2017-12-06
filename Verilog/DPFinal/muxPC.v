module muxPC(
  input [15:0] PCAdderAddr, BranchAddr,
  input PCSRC,
  output reg muxPCOut
  );

  always@(*)
    if (!PCSRC)
      muxPCOut <= PCAdderAddr;
    else
      muxPCOut <= BranchAddr;
endmodule
