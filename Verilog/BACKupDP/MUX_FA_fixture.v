`include "MUX_FA.v"

module MUX_FA_fixture;
  reg [1:0] ForwardA;
  reg [15:0] IDEX_op1, EM_op1, MWB_op1;
  wire [15:0] MUXFA_out;

initial
  $monitor("ForwardA: %b  IDEX_op1: %h  EM_op1: %h  MWB_op1:  %h\n MUX_BA_out: %h", ForwardA,IDEX_op1, EM_op1, MWB_op1, MUXFA_out);

  MUX_FA MBFA(ForwardA, IDEX_op1, EM_op1, MWB_op1, MUXFA_out);
  initial begin
    #5 ForwardA = 00;  IDEX_op1 = 13; EM_op1 = 10; MWB_op1 = 6;
    #5 ForwardA = 10;  IDEX_op1 = 13; EM_op1 = 10; MWB_op1 = 6;
    #5 ForwardA = 01;  IDEX_op1 = 13; EM_op1 = 10; MWB_op1 = 6;
  end

  initial begin
    #420 $finish;
  end
endmodule
