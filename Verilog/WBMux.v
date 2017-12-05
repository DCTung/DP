module WBMux(
  input MemToReg,
  input [15:0] ALUResult, MReadData,
  output [15:0] WriteData
  );

  always@(*)
  begin
    if(!MemToReg)
      WriteData<= ALUResult;
    else
      WriteData <= MReadData;
  end
endmodule
