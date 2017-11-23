module IDEXBuffer(
  input clk, rst;
  //from RF
  input [15:0] RD_1, RD2;
  input [15:0] signExtendedR2;

  //forwarded
  input [15:0] IFID_RS, IFID_RT;
  input IDEX.WB;
