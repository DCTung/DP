module ALUcontrol(
		input [3:0] funct,
		input [1:0] ALUop,
		output reg [2:0] operation );
always@(*)
	begin
		if(ALUop == 2'b11)
		begin
			case(funct)
				4'b0000:
					operation = 3'b000;  //add 
				4'b0010:
					operation = 3'b001;  //sub 
				4'b0100:
					operation = 3'b010;  //mult
				4'b0101:
					operation = 3'b011;  //division 
				4'b0111:
					operation = 3'b100;  //move
				4'b1000:
					operation = 3'b101;  // swap
			default:
				operation = 3'b111;          //do nothing
			endcase
		end
		else
			operation = 3'b111;                 //do nothing
	end
endmodule
