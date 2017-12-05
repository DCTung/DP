`include "MUX_FB.v"

module MUX_FB_fixture;
  reg [1:0] ForwardB;
  reg [15:0] IDEX_op2, EM_op2, MWB_op2;
  wire [15:0] MUXFB_out;

initial
  $monitor("ForwardB: %b  IDEX_op2: %h  EM_op2: %h  MWB_op2:  %h\n MUX_BA_out: %h", ForwardB,IDEX_op2, EM_op2, MWB_op2, MUXFB_out);

  MUX_FB MBFB(ForwardB, IDEX_op2, EM_op2, MWB_op2, MUXFB_out);
  initial begin
    #5 ForwardB = 00;  IDEX_op2 = 13; EM_op2 = 10; MWB_op2 = 6;
    #5 ForwardB = 10;  IDEX_op2 = 13; EM_op2 = 10; MWB_op2 = 6;
    #5 ForwardB = 01;  IDEX_op2 = 13; EM_op2 = 10; MWB_op2 = 6;
  end

  initial begin
    #420 $finish;
  end
endmodule
