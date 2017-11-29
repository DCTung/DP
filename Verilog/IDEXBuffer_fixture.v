`include "IDEXBuffer.v";

module IDEXBuffer_fixture;
reg clk, rst, IDEX_FLUSH;
reg [15:0] RD1, RD2, signExtendedR2;
reg [15:0] IFID_RS, IFID_RT;
reg [1:0] ALUOP_in;
reg [3:0] funct_code_in;

reg R15_in, ALUSrc_in,MemToReg_in, RegWrite_in, MemRead_in, MemWrite_in, Branch_in;

wire R15_out,
   ALUSrc_out,
   MemToReg_out,
   RegWrite_out,
   MemRead_out,
   MemWrite_out,
   Branch_out, ALUOP_out, RD1_out, RD2_out, signExtendedR2_out, funct_code_out;

   initial
   $monitor($time, "Input: \n IDEX_FLUSH: %1b R15: %1b RD1: %h RD2: %h SignExtended: %h IFID_RS: %h IFID_RT: %h ALUOP_In: %h Funct Code In: %h \n   Control Input: R15_in: %b ALUSrc_in %b MemToReg_in %b RegWrite_in %b MemRead_in %b MemWrite_in %b Branch_in %b \n Output: R15_out: %b ALUSrc_out %b MemToReg_out %b RegWrite_out %b MemRead_out %b MemWrite_out %b Branch_out %b ALUOP_out %b RD1_out %b RD2_out %b signExtendedR2_out %b funct_code_out %b",
   IDEX_FLUSH, R15_in, RD1, RD2, signExtendedR2, IFID_RS, IFID_RT, ALUOP_in, funct_code_in, R15_in, ALUSrc_in,MemToReg_in, RegWrite_in, MemRead_in, MemWrite_in, Branch_in,
   R15_out, ALUSrc_out,
      MemToReg_out,
      RegWrite_out,
      MemRead_out,
      MemWrite_out,
      Branch_out, ALUOP_out, RD1_out, RD2_out, signExtendedR2_out, funct_code_out);

    IDEXBuffer I1(clk, rst, IDEX_FLUSH, RD1, RD2, signExtendedR2, funct_code_in, IFID_RS, IFID_RT, R15_in, ALUSrc_in, RegWrite_in, MemRead_in, Branch_in, ALUOP_in,R15_out,
       ALUSrc_out,
       MemToReg_out,
       RegWrite_out,
       MemRead_out,
       MemWrite_out,
       Branch_out, ALUOP_out, RD1_out, RD2_out, signExtendedR2_out, funct_code_out);

       // Stimulate the Clear Signal
  /*        initial
    begin
              rst = 1'b1;
              #34 rst = 1'b0;
              #200 rst = 1'b1;
              #50 rst = 1'b0;
       end
*/
       // Setup the clk to toggle every 10 time units
       initial
       begin
              clk = 1'b0;
              forever #10 clk = ~clk;
       end

       // Finish the  simulation at time 200
       initial
       begin
              #400 $finish;
       end

       initial begin
       #20
       IDEX_FLUSH = 0;
       RD1 = 3;
       RD2 = 7;
       signExtendedR2 = 8;
       IFID_RS = 9;
       IFID_RT = 4;
       ALUOP_in = 2'b01;
       funct_code_in =4'b0010;
    //   4'b1111:  //TypeA
         R15_in = 1;
         ALUSrc_in = 0;
         MemToReg_in = 1;
         RegWrite_in = 1;
         MemRead_in = 0;
         MemWrite_in = 0;
         Branch_in = 0;
         ALUOP_in = 2'b11;

         #20
         IDEX_FLUSH = 1;
         RD1 = 3;
         RD2 = 7;
         signExtendedR2 = 8;
         IFID_RS = 9;
         IFID_RT = 4;
         ALUOP_in = 2'b01;
         funct_code_in =4'b0010;
         //   4'b1111:  //TypeA
           R15_in = 1;
           ALUSrc_in = 0;
           MemToReg_in = 1;
           RegWrite_in = 1;
           MemRead_in = 0;
           MemWrite_in = 0;
           Branch_in = 0;
           ALUOP_in = 2'b11;

           #20
           IDEX_FLUSH = 0;
           RD1 = 3;
           RD2 = 7;
           signExtendedR2 = 8;
           IFID_RS = 9;
           IFID_RT = 4;
           ALUOP_in = 2'b01;
           funct_code_in =4'b0010;
        //   4'b1111:  //TypeA
             R15_in = 1;
             ALUSrc_in = 0;
             MemToReg_in = 1;
             RegWrite_in = 1;
             MemRead_in = 0;
             MemWrite_in = 0;
             Branch_in = 0;
             ALUOP_in = 2'b11;

             #20
             IDEX_FLUSH = 1;
             RD1 = 3;
             RD2 = 7;
             signExtendedR2 = 8;
             IFID_RS = 9;
             IFID_RT = 4;
             ALUOP_in = 2'b01;
             funct_code_in =4'b0010;
             //   4'b1111:  //TypeA
               R15_in = 1;
               ALUSrc_in = 0;
               MemToReg_in = 1;
               RegWrite_in = 1;
               MemRead_in = 0;
               MemWrite_in = 0;
               Branch_in = 0;

         end
  initial begin
    #300 $finish;
    end
  endmodule
