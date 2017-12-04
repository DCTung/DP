module BL_add(
    input [15:0] SE,
    input [15:0] PC_in,
    output reg [15:0] BL_result
  );
  always@(*)
  begin
  		BL_result <= SE + PC_in;
  end
endmodule
