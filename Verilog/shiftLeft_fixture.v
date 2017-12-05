`incude "shiftLeft.v"
module shiftLeft_fixture;
  reg [15:0] signExtendedR2;
  wire [15:0] shiftedOut;

initial
  $monitor($time, "\n Input: \nsignExtendedR2 = %h \n Output: \n shiftedOut = %h\n", signExtendedR2, shiftedOut);

shiftLeft SL(signExtendedR2, shiftedOut);
initial
  begin
  #5 signExtendedR2 = 5;
  #5 signExtendedR2 = 19;
  #5 signExtendedR2 = 7;
  end

  initial begin
    #420 $finish;
  end
endmodule
