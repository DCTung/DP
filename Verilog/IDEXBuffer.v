 module IDEXBuffer(
  input IDEX_FLUSH,

  //from RF
  input [15:0] RD1, RD2,
  input [15:0] signExtendedR2,
  input [3:0] funct_code_in, opcode, //funky code ;)

  input [7:0] addr_in,

  //forwarded IN
  input [3:0] IFID_RS, IFID_RT,

  //Cunit ins
  input R15_in, ALUSrc_in, MemToReg_in, RegWrite_in, MemRead_in, MemWrite_in, Branch_in,
  input [1:0] ALUOP_in,

  //Cunit Outs
  output reg R15_out,
  output reg ALUSrc_out,
  output reg MemToReg_out,
  output reg RegWrite_out,
  output reg MemRead_out,
  output reg MemWrite_out,
  output reg Branch_out,
  output reg [1:0] ALUOP_out,
  output reg [7:0] addr_out,

  //RF outs
  output reg [15:0] RD1_out, RD2_out,
  output reg [15:0] signExtendedR2_out,
  output reg [3:0] funct_code_out, opcode_out,

  //forwarded Out
  output reg [3:0] IFID_RS_OUT, IFID_RT_OUT);

//i think that's all :)

always@(*)
 if(!IDEX_FLUSH)
 begin
    R15_out = R15_in;
    ALUSrc_out = ALUSrc_in;
    MemToReg_out = MemToReg_in;
    RegWrite_out = RegWrite_in;
    MemRead_out =  MemRead_in;
    MemWrite_out = MemWrite_in;
    Branch_out = Branch_in;
    ALUOP_out = ALUOP_in;
    RD1_out = RD1;
    RD2_out = RD2;
    funct_code_out = funct_code_in;
    IFID_RS_OUT = IFID_RS;
    IFID_RT_OUT = IFID_RT;

    //if ALUSrc_in = 1 then signextended taken -- for Type C?
    //@@@@@@@need a Type D condition
    if (ALUSrc_in)
      signExtendedR2_out = (signExtendedR2 + RD2);
    else
      signExtendedR2_out = signExtendedR2;


  end
    else if(IDEX_FLUSH) //FLUSH sigs to 0
    begin
      R15_out = 0;
      ALUSrc_out = 0;
      MemToReg_out = 0;
      RegWrite_out = 0;
      MemRead_out =  0;
      MemWrite_out = 0;
      Branch_out = 0;
      ALUOP_out = 0;
      RD1_out = 0 ;
      RD2_out = 0;
      signExtendedR2_out=0;
      funct_code_out = 0;
      IFID_RS_OUT = 0;
      IFID_RT_OUT = 0;
    end
  endmodule
