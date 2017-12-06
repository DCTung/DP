`include "MWBBuffer.v"
module MWBBuffer_fixture;

reg MemToReg_in, RegWrite_in;
reg [15:0] ALU_Result, ReadData;
reg [3:0] movOP_in;

wire MemToReg_out, RegWrite_out;
wire [15:0] ALU_Result_out, ReadData_out;
wire [3:0] movOP_out;

initial
$monitor($time, "\n Input:\nMemToReg_in: %b RegWrite_in: %b ALU_Result: %h ReadDate: %h movOP_in: %h\n Output:\n MemToReg_out: %b RegWrite_out: %b ALU_Result_out: %h ReadData_out: %h, movOP_out: %h", MemToReg_in, RegWrite_in, ALU_Result, ReadData, movOP_in, MemToReg_out, RegWrite_out, ALU_Result_out, ReadData_out, movOP_out);

MWBBuffer_fixture mwbb1(MemToReg_in, RegWrite_in, ALU_Result, ReadData, movOP_in,MemToReg_out, RegWrite_out, ALU_Result_out, ReadData_out, movOP_out);

initial begin
#10
MemToReg_in = 1;
RegWrite_in = 1;
ALU_Result = 13;
ReadData = 18;
movOP_in = 5;
end
initial begin
#1000 $finish;
end
endmodule
