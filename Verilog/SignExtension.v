module SignExtension(
  input [3:0] toExtend,

  output reg [15:0] signExtended
  );

//take full instr but only grab bottom 4
always@(*)
begin
  signExtended = {{16{toExtend[3]}}, toExtend[3:0};
end
endmodule
