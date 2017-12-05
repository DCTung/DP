module branchLogic(
  input [15:0] rd1, rd15;
  input [3:0] opcode;
  input branch;
  output reg PCSRC;
  );

  always@(*)
  begin
    if(branch)
      case(opcode)
        4'b0101:
          if(rd1 < rd15)
            PCSRC=0;
        4'b0100:
          if(rd1 > rd15)
            PCSRC=0;
        4'b0110:
          if(rd1 == rd15)
            PCSRC=0;
        default:
            PCSRC=1;
  end
endmodule
