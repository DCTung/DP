module HazardDetection(
  //out PCWRITE OUT IFIDWRITE IN Registers INIFIDREGRD OUT STALL, IN IDEXMEMRD

  //if hazard -- disable PCWRITE (we don't have PCwrite signal tho?)
  //only covers LW haz atm?

  input [3:0] IFID_op1, IFID_op2, IDEX_op1,
  input IDEX_MemRead, rst,
  output reg STALL,
  output reg PCWrite, IFID_Write
  );

  always@(*)
  if(!rst)
  begin
    if(IDEX_MemRead == 1 && (IFID_op1 == IDEX_op1 || IFID_op2 == IDEX_op1))
    begin
      STALL=1;
      PCWrite =0;
      IFID_Write =0;
    end
    else
    begin
      STALL=0;
      PCWrite = 1;
      IFID_Write = 1;
    end
  end
endmodule

/* double check this from book
if(IDEX.MEMRead and ((idex.regrt = ifid.regrs) or idex.regrt = ifid.regret)))
stall
*/
