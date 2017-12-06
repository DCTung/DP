module BL_add(
    input [15:0] SE,
    input [7:0] PC_in,
    output reg [7:0] BL_result
  );
  always@(*)
  begin
  		BL_result <= SE[7:0] + PC_in;
  end
endmodule
