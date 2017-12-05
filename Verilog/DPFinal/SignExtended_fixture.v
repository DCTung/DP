`include "SignExtension.v";

module SignExtended_fixture;

reg[3:0] toExtend;
wire[15:0] signExtended;

initial
$monitor($time, "\n Input toExtend: %16b\n Output Sign Extended: %16b", toExtend, signExtended);

SignExtension SE(toExtend, signExtended);

initial begin
#5
toExtend = 4'b1101;
#5
toExtend = 4'b0010;
#5
toExtend = 4'b1000;
#5
toExtend = 4'b0001;
end
endmodule
