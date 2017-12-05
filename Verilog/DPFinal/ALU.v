module ALU(
  input [3:0] operation,
  input signed [15:0] op1, op2,
  output reg signed [15:0] result,
  output reg [15:0] remainder,
  output reg o
  //need other condits
  );

  always@(*)
	begin
    		case(operation)
      			4'b0001:
        			result = op1 + op2;    // ADD
      			4'b0010: //sub
				result = op1 - op2;    // sub
      			4'b0011: 
      			begin
        			result = op1 * op2;    //mult
        			remainder = op1%op2;   
      			end
      			4'b0100: 			//divvies
      			begin
        			result = op1/op2;
        			remainder = op1%op2;
      			end
      			4'b0101: 			//move
        			result = op1;
      			4'b0110: 			//swappies
        			result = op1;
       				//op2 straight to buff?
			4'b0111:
				result = op1 & op2;
			4'b1000:
				result = op1 | op2;
			4'b1001:
				result	= op1 ^ op2;
      		endcase
		if(result > 16'hFFFF)
			o = 1;
		else 
			o = 0;

    end
endmodule
