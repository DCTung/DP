//i'm the control mod

module control(
  input [3:0] opCode,
  output R15,
  output ALUSrc,
  output MemToReg,
  output RegWrite,
  output MemRead,
  output MemWrite,
  output Branch,
  output [1:0] ALUOP,
  );

  always@(*)
    case(opcode)
    4'b1111:  //TypeA
    begin
      R15 = 1;
      ALUSrc = 0;
      MemToReg = 1;
      RegWrite = 1;
      MemRead = 0;
      MemWrite = 0;
      Branch = 0;
      ALUOP = 2'b11;
    end

    4'b1000: //AND imm
    begin
      R15 = 0;
      ALUSrc = 0;
      MemToReg = 1;
      RegWrite = 1;
      MemRead = 0;
      MemWrite = 0;
      Branch = 0;
      ALUOP = 2'b11;
    end

    4'b1001: //OR imm
    begin
      R15 = 0;
      ALUSrc = 1;
      MemToReg = 1;
      RegWrite = 1;
      MemRead = 0;
      MemWrite = 0;
      Branch = 0;
      ALUOP = 2'b10;
    end

      4'b1010:  //LBU
      begin
        R15 = 0;
        ALUSrc = 1;
        MemToReg = 0;
        RegWrite = 1;
        MemRead = 0;
        MemWrite = 0;
        Branch = 0;
        ALUOP = 2'b10;
      end

      4'b1011: //SB
      begin
        R15 = 0;
        ALUSrc = 1;
        MemToReg = 0;
        RegWrite = 1;
        MemRead = 0;
        MemWrite = 0;
        Branch = 0;
        ALUOP = 2'b10;
      end

      4'b1100:  //LB
      begin
        R15 = 0;
        ALUSrc = 1;
        MemToReg = 0;
        RegWrite = 0;
        MemRead = 0;
        MemWrite = 0;
        Branch = 1;
        ALUOP = 2'b01;
      end

      4'b1101: //Store
      begin
        R15 = 0;
        ALUSrc = 1;
        MemToReg = X;
        RegWrite = 1;
        MemRead = 0;
        MemWrite = 1;
        Branch = 0;
        ALUOP = 2'b00;
      end

      //Type C
      4'b0101:  //blt
      begin
        R15 = 1;
        ALUSrc = 1;
        MemToReg = x;
        RegWrite = 1;
        MemRead = 0;
        MemWrite = 0;
        Branch = 1;
        ALUOP = 2'b01;
      end

      4'b0100:  //bgt
      begin
        R15 = 1;
        ALUSrc = 1;
        MemToReg = x;
        RegWrite = 1;
        MemRead = 0;
        MemWrite = 0;
        Branch = 1;
        ALUOP = 2'b01;
      end

      4'b0110: //blt
      begin
        R15 = 1;
        ALUSrc = 1;
        MemToReg = x;
        RegWrite = 1;
        MemRead = 0;
        MemWrite = 0;
        Branch = 1;
        ALUOP = 2'b01;
      end

      //Type D
      4'b0001:  //jump
      begin
        R15 = 0;
        ALUSrc = 1;
        MemToReg = 0;
        RegWrite = 0;
        MemRead = 0;
        MemWrite = 0;
        Branch = 0;
        ALUOP = 2'b00;
      end

      4'b0000:  //jump
      begin
        R15 = 0;
        ALUSrc = 0;
        MemToReg = 0;
        RegWrite = 0;
        MemRead = 0;
        MemWrite = 0;
        Branch = 0;
        ALUOP = 2'b00;
      end
endcase

endmodule
