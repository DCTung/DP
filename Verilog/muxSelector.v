module muxSelector(
  input [15:0] PCAdderAddr, BranchAddr,
  input PCSRC,
  output reg muxPCOut
  );

  always@(*)
    if (!PCSRC)
      muxPCOUT <= PCadderAdr;
    else
      muxPCOUT <= BranchAddr;
    end
endmodule
