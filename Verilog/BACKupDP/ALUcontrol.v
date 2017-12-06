module ALUcontrol(
		input clk, reset,
		input [3:0] funct,
		input [1:0] ALUop,
		output reg [3:0] operation );
always@(*)
	//if(reset)
	//	operation <= 4'h1;
	//else
		begin
			case(ALUop)
				2'b11:
					case(funct)
					4'b0000:
						operation <= 4'b0001;  //add
					4'b0001:
						operation <= 4'b0010;  //sub
					4'b0100:
						operation <= 4'b0011;  //mult
					4'b0101:
						operation <= 4'b0100;  //division
					4'b0111:
						operation <= 4'b0101;  //move
					4'b1000:
						operation <= 4'b0110;  //swap
					4'b1001:
						operation <= 4'b0111;  //AND gate
					4'b1010:
						operation <= 4'b1000;  //OR gate
					endcase
				2'b10:
					operation <= 4'b0001;	      //load & store (add)
				2'b01:
					operation <= 4'b1001;          //branch (comparison)
				2'b00:
					operation <= 4'b0000;           //jump/halt
			endcase
		end
endmodule