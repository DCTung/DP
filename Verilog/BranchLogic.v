module branchLogic(
  input [15:0] rd1, rd15,
  input [3:0] opcode,
  input branch,
  output reg PCSRC
  );
  always@(*)
  begin
    if(branch)
      case(opcode)
        4'b0101:
        begin
          if(rd1 < rd15)
            PCSRC=0;
        end
        4'b0100:
        begin
          if(rd1 > rd15)
            PCSRC=0;
        end
        4'b0110:
        begin
          if(rd1 == rd15)
            PCSRC=0;
        end
        default:
            PCSRC=1;
      endcase
  end
endmodule
