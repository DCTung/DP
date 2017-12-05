`include "ALUcontrol1.v";
module ALUcontrol1_fixture;

reg [3:0] funct;
reg [1:0] ALUop;
wire [3:0] operation;

initial
	$monitor ($time," funct = %b, ALUop = %b, operation = %b",funct, ALUop,operation);
ALUcontrol1 A1(funct, ALUop, operation);

initial
begin
	ALUop = 2'b11; funct = 4'b0001;
	#5
	ALUop = 0;
	#5
	ALUop = 2'b11;
		  #10  funct = 4'b0010;
		  #10  funct = 4'b0011;
		  #10  funct = 4'b0100;
		  #10  funct = 4'b0101;
		  #10  funct = 4'b0110;
		  #10  funct = 4'b1111;
		  #10
	ALUop = 2'b10;
	          #10
	ALUop = 2'b11;
		  #10
	ALUop = 2'b01;
		  #10
	ALUop = 2'b00;
end

initial
	begin
		#200 $finish;
	end
endmodule
