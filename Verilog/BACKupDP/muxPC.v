module muxPC(
  input [15:0] PCAdderAddr, BranchAddr,
  input PCSRC,
  output reg [15:0] muxPCOut
  );

  always@(*)
    if (PCSRC)
      muxPCOut = PCAdderAddr;
    else
      muxPCOut = BranchAddr;
endmodule
