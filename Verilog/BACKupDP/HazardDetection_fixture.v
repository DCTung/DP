`include "HazardDetection.v"

module HazardDetection_fixture;

reg [3:0] IFID_op1, IFID_op2, IDEX_op1;
reg IDEX_MemRead, rst;
wire STALL, PCWrite, IFID_Write;

initial
$monitor($time, "\n INPUT:\n IFID_op1: %h IFID_op2: %h IDEX_op1: %h \n IDEX_MemRead: %b Reset: %b\n OUTPUT:\n STALL: %b PCWrite: %b IFID_Write: %b", IFID_op1, IFID_op2, IDEX_op1, IDEX_MemRead, rst, STALL, PCWrite, IFID_Write);

HazardDetection HDF(IFID_op1, IFID_op2, IDEX_op1, IDEX_MemRead, rst, STALL, PCWrite, IFID_Write);

initial begin
rst = 1;
#10
rst = 0;
IDEX_MemRead = 1;
IFID_op1 = 12;
IFID_op2 = 13;
IDEX_op1 = 12;

#10
IDEX_MemRead = 1;
IFID_op1 = 15;
IFID_op2 = 10;
IDEX_op1 = 3;

#10
IDEX_MemRead = 1;
IFID_op1 = 4;
IFID_op2 = 5;
IDEX_op1 = 5;
end
initial begin
#1000 $finish;
end
endmodule
