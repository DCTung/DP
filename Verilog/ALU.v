module ALU(
  input clk, rst,
  input [3:0] functCode,
  input signed [15:0] op1, op2,
  output reg signed [15:0] result,
  output reg [15:0] remainder,
  output reg o
  //need other condits
  );
  reg signed [31:0] temp;
  always@(posedge clk, negedge rst)
  begin
  if(!rst)
    begin
    result <= 0;
    remainder <=0;
    temp <= 0;
    o <= 0;
    end
    else if(rst)
    begin
    case(functCode)
      4'b0000: //addies
      begin
        temp = op1 + op2;
        result <= temp[15:0];
      end  //need overflow detection for each @@@@

      4'b0001: //subbies
      begin
        temp = op1 - op2;
        result <= temp[15:0];
      end

      4'b0100: //multiplic
      begin
        temp = op1 * op2;
        remainder = op1%op2;
        result = temp[15:0];
      end

      4'b0101: //divvies
      begin
        result = op1/op2;
        remainder = op1%op2;
      end
      4'b0111: //move
        result = op1 + 0;

      4'b1000: //swappies
        result = op1;
        //op2 straight to buff?
      endcase
    end
    end
  endmodule
