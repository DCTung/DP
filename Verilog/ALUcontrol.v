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
					operation = 4'b0000;  //add 
				4'b0010:
					operation = 4'b0001;  //sub 
				4'b0100:
					operation = 4'b0010;  //mult
				4'b0101:
					operation = 4'b0011;  //division 
				4'b0111:
					operation = 4'b0100;  //move
				4'b1000:
					operation = 4'b0101;  // swap
			default:
				operation = 4'b1111;          //do nothing
			endcase
		end
		else
			operation = 4'b1111;                 //do nothing
	end
endmodule
