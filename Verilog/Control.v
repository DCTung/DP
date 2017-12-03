//i'm the control mod

module control(
  input clk, reset,
  input [3:0] con_opcode,
  output reg R15,
  output reg ALUSrc,
  output reg MemToReg,
  output reg RegWrite,
  output reg MemRead,
  output reg MemWrite,
  output reg Branch,
  output reg [1:0] ALUOP
  );

  always@(posedge clk)
  begin
	if(reset)
	begin
		R15 <= 1'b0;
      		ALUSrc <= 1'b0;
      		MemToReg <= 1'b1;
      		RegWrite <= 1'b1;
      		MemRead <= 1'b0;
      		MemWrite <= 1'b0;
      		Branch <= 1'b0;
      		ALUOP <= 2'b11;
	end
	else
	begin
		case(con_opcode)
 			4'b1111:  //TypeA
    			begin
      				R15 <= 1;
      				ALUSrc <= 0;
      				MemToReg <= 1;
     				RegWrite <= 1;
      				MemRead <= 0;
      				MemWrite <= 0;
      				Branch <= 0;
      				ALUOP <= 2'b11;
    			end

    			4'b1000: //AND imm
    			begin
      				R15 <= 0;
      				ALUSrc <= 0;
      				MemToReg <= 1;
      				RegWrite <= 1;
      				MemRead <= 0;
      				MemWrite <= 0;
      				Branch <= 0;
      				ALUOP <= 2'b11;
    			end

    			4'b1001: //OR imm
    			begin
      				R15 <= 0;
      				ALUSrc <= 1;
      				MemToReg <= 1;
      				RegWrite <= 1;
      				MemRead <= 0;
      				MemWrite <= 0;
      				Branch <= 0;
      				ALUOP <= 2'b11;
    			end

      			4'b1010:  //LBU
      			begin
        			R15 <= 0;
        			ALUSrc <= 1;
        			MemToReg <= 0;
        			RegWrite <= 1;
        			MemRead <= 0;
        			MemWrite <= 0;
        			Branch <= 0;
        			ALUOP <= 2'b10;
      			end

      			4'b1011: //SB
      			begin
        			R15 <= 0;
        			ALUSrc <= 1;
        			MemToReg <= 0;
        			RegWrite <= 1;
        			MemRead <= 0;
        			MemWrite <= 0;
        			Branch <= 0;
        			ALUOP <= 2'b10;
      			end

      			4'b1100:  //LB
      			begin
        			R15 <= 0;
        			ALUSrc <= 1;
        			MemToReg <= 0;
       				RegWrite <= 0;
        			MemRead <= 0;
        			MemWrite <= 0;
        			Branch <= 1;
        			ALUOP <= 2'b10;
      			end

      			4'b1101: //Store
      			begin
        			R15 <= 0;
        			ALUSrc <= 1;
        			MemToReg <= 0;
        			RegWrite <= 1;
        			MemRead <= 0;
        			MemWrite <= 1;
       				Branch <= 0;
       				ALUOP <= 2'b10;
      			end

      			//Type C
     			4'b0101:  //blt
      			begin
        			R15 <= 1;
        			ALUSrc <= 1;
        			MemToReg <= 0;
        			RegWrite <= 1;
        			MemRead <= 0;
        			MemWrite <= 0;
        			Branch <= 1;
        			ALUOP <= 2'b01;
      			end

      			4'b0100:  //bgt
      			begin
       				R15 <= 1;
        			ALUSrc <= 1;
        			MemToReg <= 0;
        			RegWrite <= 1;
        			MemRead <= 0;
        			MemWrite <= 0;
        			Branch <= 1;
        			ALUOP <= 2'b01;
      			end

      			4'b0110: //blt
      			begin
        			R15 <= 1;
        			ALUSrc <= 1;
        			MemToReg <= 0;
        			RegWrite <= 1;
        			MemRead <= 0;
        			MemWrite <= 0;
        			Branch <= 1;
        			ALUOP <= 2'b01;
      			end

      			//Type D
      			4'b0001:  //jump
      			begin
        			R15 <= 0;
        			ALUSrc <= 1;
        			MemToReg <= 0;
        			RegWrite <= 0;
        			MemRead <= 0;
        			MemWrite <= 0;
        			Branch <= 0;
        			ALUOP <= 2'b00;
      			end

      			4'b0000:  //jump
      			begin
       				R15 <= 0;
        			ALUSrc <= 0;
       				MemToReg <= 0;
        			RegWrite <= 0;
        			MemRead <= 0;
        			MemWrite <= 0;
        			Branch <= 0;
        			ALUOP <= 2'b00;
      			end
		endcase
	end
end
endmodule
