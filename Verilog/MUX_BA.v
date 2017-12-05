module MUX_BA(
  input [1:0] ForwardB,
  input [15:0] IDEX_op1, EM_op1, MWB_op1,
  output reg [15:0] MUXFB_out
  );

  always@(*)
  begin
    case(ForwardB)
      2'b00:
        MUXFB_out =IDEX_op1;
      2'b10:
        MUXFB_out = EM_op1;
      2'b01:
        MUXFB_out =MWB_op1;
    endcase
  end
endmodule


        //Control Table
        /*
        FA = 00 Source: IDEX if from regFile
        FB = 00 Source IDEX from reg file

        FA10 - EXMEM - From prior ALU Result
        FA01 - MEMWB - From DM or earlier ALU

        FB10 - EXMEM - forwarded form prior ALU Result
        FB01 - MEMWB - from dm or an earlier ALU result

        */
