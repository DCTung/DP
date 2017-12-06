//"Study the past if you would define the future" -Confucius
// "no one like you" -mom


//Hazard conditions
//1a. EX/MEM.registerRD = ID/EX.RegsiterRS
//1b. ----------------- = ID/EX.RegisterRT
//2a. MEM/WB.RegisterRD = IDEX.RegisterRS
//2b. ----------------- = IDEX.RegisterRT


//Control Table
/*
FA = 00 Source: IDEX if from regFile
FB = 00 Source IDEX from reg file

FA10 - EXMEM - From prior ALU Result
FA01 - MEMWB - From DM or earlier ALU

FB10 - EXMEM - forwarded form prior ALU Result
FB01 - MEMWB - from dm or an earlier ALU result

*/

/* Page 308 EX Hazz
if(EX/MEM.RegWrite && (EX/Mem.RegRD != 0) && (EX/MEM.RegRD = IDEX.RegRS)) ForwardA = 10

if(EXMEM.RegWrite && (EXMEM.RegRd != 0) && (EXMEMRegRd = IDEX.RegRT)) ForwardB = 10

Page 310 MEM Hazz

if(MEMWB.RegWritee && ( MEMWB.RegRd != 0) and (MemWBRegRD = IDEX.RegRS)) ForwardA =01

if(MEMWB.RegWrite && (MEMWB.RegRd !=0) and (MEMWB.RegRD = IDEX.RegRt)) ForwardB = 01
*/


/* IN THE CONTEXT OF OURS? */

module ForwardingUnit(
  //Reg check
  input [3:0] EM_RD, MWB_RD, ID_OP1, ID_OP2,
  //wires
  input EM_RegWrite, MWB_RegWrite,
  output reg [1:0] ForwardA, ForwardB
  //FA FB feed into the MUX
  );
  always@(*)
  begin
    if((EM_RegWrite) && (EM_RD != 0) && (EM_RD == ID_OP1))
      ForwardA = 2'b10;
    else if((MWB_RegWrite) && (MWB_RD !=0) && (MWB_RD == ID_OP1))
      ForwardA = 2'b01;
    else
      ForwardA = 2'b00;

    if ((EM_RegWrite)&&(EM_RD !=0)&&(EM_RD == ID_OP2))
      ForwardB = 2'b10;
    else if((MWB_RegWrite)&&(MWB_RD != 0) && (MWB_RD == ID_OP2))
      ForwardB = 2'b01;
    else
      ForwardB = 2'b00;
  end
endmodule
