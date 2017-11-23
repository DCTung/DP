//i want to make PC module

module TestMod;

reg clk, rst;
reg[7:0] addr_in;
wire[7:0] addr_out;
wire[7:0] instr_out;

PC pcraw(clk,rst, addr_in, addr_out);
IM imraw(clk,rst, addr_in, instr_out);

initial
$monitor($time, "instr_out = %b", instr_out);

initial
	begin
		clk = 1'b0;
		forever #10 clk = ~clk;
	end
initial
	begin
	rst = 1;
	addr_in = 8'b11111111;
	#20;
	rst = 0;
end
initial
	begin
		#200 $finish;
	end
endmodule


module PC(input clk, input rst, input [7:0] addr_in, output reg [7:0] addr_out);
always@(posedge clk, negedge rst)
	begin
		if(rst)
			addr_out<= 8'h00;
		else
			addr_out<= addr_in;
	end
endmodule

module IM(
	input clk, rst,
	input [7:0] addr_in,
	output reg [7:0] instr_out);
always@(posedge clk, negedge rst)
	begin
		if(rst)
			instr_out <= 8'b00000000;
		else
		//begin here
		instr_out <= addr_in;
	end
endmodule