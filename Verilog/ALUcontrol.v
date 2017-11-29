module ALUcontrol(
		input [3:0] funct,
		input [1:0] ALUop,
		output reg [3:0] operation );
always@(*)
		begin
			case(ALUop)
				2'b11:
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
						operation = 4'b1111;  //do nothing
				2'b10:
					operation = 4'b0111;		
				
			endcase
		end
		else
			operation = 3'b111;                 //do nothing
	end
endmodule
