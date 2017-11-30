module ALUcontrol(
		input [3:0] funct,
		input [1:0] ALUop,
		output reg [3:0] operation );
always@(*)
		begin
			if(ALUop == 2'b11)
			begin
					case(funct)
					4'b0000:
						operation = 4'b0001;  //add
					4'b0010:
						operation = 4'b0010;  //sub
					4'b0100:
						operation = 4'b0011;  //mult
					4'b0101:
						operation = 4'b0100;  //division
					4'b0111:
						operation = 4'b0101;  //move
					4'b1000:
						operation = 4'b0110;  // swap
					default:
						operation = 4'b0001;  //will never occur
					endcase
				end
				else if(ALUop == 2'b10)
					operation = 4'b0111;	      //OR & AND operation
				else if(ALUop == 2'b11)
					operation = 4'b0001;	      //load & store (add)
				else if(ALUop == 2'b01)
					operation = 4'b1001;          //branch (comparison)
				else if(ALUop == 2'b00)
					operation = 4'b0000;           //jump/halt
			end
endmodule
