`include "ForwardingUnit.v"

module ForwardingUnit_fixture;

reg [3:0] EM_RD, MWB_RD, ID_OP1, ID_OP2;
reg EM_RegWrite, MWB_RegWrite;
wire [1:0] ForwardA, ForwardB;

initial
  $monitor($time, "\n Input \n EM_RD: %h MWB_RD: %h ID_OP1: %h ID_OP2: %h \n EM_RegWrite: %b MWB_RegWrite: %b \n OUTPUT \n ForwardA: %h ForwardB: %h", EM_RD, MWB_RD, ID_OP1, ID_OP2, EM_RegWrite, MWB_RegWrite, ForwardA, ForwardB);

ForwardingUnit FU(EM_RD, MWB_RD, ID_OP1, ID_OP2, EM_RegWrite, MWB_RegWrite, ForwardA, ForwardB);

initial begin
  #5
  EM_RD = 12;
  MWB_RD = 13;
  ID_OP1 = 12;
  ID_OP2 = 15;
  EM_RegWrite = 1;
  MWB_RegWrite= 0;
  #5
  EM_RD = 12;
  MWB_RD = 13;
  ID_OP1 = 12;
  ID_OP2 = 15;
  EM_RegWrite = 0;
  MWB_RegWrite= 1;
  #5
  EM_RD = 12;
  MWB_RD = 13;
  ID_OP1 = 11;
  ID_OP2 = 13;
  EM_RegWrite = 1;
  MWB_RegWrite= 0;
  #5
  EM_RD = 12;
  MWB_RD = 13;
  ID_OP1 = 11;
  ID_OP2 = 13;
  EM_RegWrite = 0;
  MWB_RegWrite= 1;
  #5
  EM_RD = 12;
  MWB_RD = 13;
  ID_OP1 = 11;
  ID_OP2 = 12;
  EM_RegWrite = 0;
  MWB_RegWrite= 1;
  #5
  EM_RD = 12;
  MWB_RD = 13;
  ID_OP1 = 11;
  ID_OP2 = 12;
  EM_RegWrite = 1;
  MWB_RegWrite= 0;
  #5
  EM_RD = 12;
  MWB_RD = 13;
  ID_OP1 = 16;
  ID_OP2 = 15;
  EM_RegWrite = 1;
  MWB_RegWrite= 0;
  end
  endmodule
