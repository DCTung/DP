module PC (input clk, reset, input [7:0] addr_in, output reg [7:0] addr_out);
always@(posedge clk or negedge reset)
	begin
		if(reset)
			addr_out <= 8’h00;
		else
			addr_out <= addr_in;
	end
endmodule
--------------------------------------------------------------------------------------------------------------------------------
`include "PC.v"
module PC_fixture;
reg clk, reset;
reg [7:0] addr_in;
wire [7:0] addr_out;
initial
	$monitor($time, " clk = %b, reset = %b, addr_in = %h, addr_out = %h ", clk, reset, addr_in, addr_out);
PC t1(clk, reset,addr_in, addr_out);
initial
	begin
		clk = 1'b0;
		forever #10 clk = ~clk;
	end
initial
	begin
	reset = 1;
			 #20 reset = 0; addr_in = 8'h01;
			 #20                 addr_in = 8'hFF;
			 #20 		addr_in = 8'hF0;
			 #20		addr_in = 8'h0F;
			 #20		addr_in = 8'h07;
			 #20		addr_in = 8'h0A;
			 #20 		addr_in = 8'h0C;
	reset = 1;
	end
initial
	begin
		#180 $finish;
	end
endmodule






module mux2to1(input select, input [7:0] nojump, jump, output reg [7:0] cur_addr);
always@(*)
	begin
		if(!select)                   //select = 0 then, there’s no jump & continue to the next addr
			cur_addr = nojump;
		else 		         //select = 1 then, there’s a jump/branch & jump to the
        // specified addr due to jump/branch
			cur_addr = jump;
	end
endmodule
--------------------------------------------------------------------------------------------------------------------------------
`include "mux2to1.v"
module mux2to1_fixture;
reg [7:0] nojump, jump;
reg select;
wire [7:0] cur_addr;

initial $monitor("select = %b, nojump = %h, jump = %h, cur_addr = %h",select, nojump, jump,cur_addr);

mux2to1 m1(select, nojump, jump,cur_addr);
initial
	begin
		select = 1'b0; nojump = 8'h0F;  jump = 8'hF0;
	#10	select = 1'b1;
	#10	select = 1'b0; nojump = 8'h55;  jump = 8'h44;
	#10	select = 1'b1;
	#10	select = 1'b0; nojump = 8'h00;  jump = 8'hFF;
	#10 	select = 1'b1;
	end
initial
	begin
		#70 $finish;
	end
endmodule













module IM(addr_in, instr);
input addr_in;
output instr;
parameter SIZE = 30;
	reg [15:0] mem[0:SIZE-1];

		always@(*)
			initial
	begin
	for(k=0; k<SIZE - 1; k = k+1)
	begin
		mem[k] = 'h00;	//init all 0000

		//put the instructions in here
		mem[0] = 'hF120
	end else
		instr <= mem[addr_in]
	end
endmodule





























module IFIDbuffer(input clk, input reset,  input [15:0] instruc_in, input [7:0] addr_in, output reg [15:0] instruc_out, output reg [7:0] addr_out);

always@(posedge clk or negedge reset)
	begin
		if(reset)
			instruc_out <= 16’h0000;
			addr_out <= 8’h00;
		else
			instruc_out <= instruc_in;
			addr_out <= addr_in;

	end
endmodule

-------------------------------------------------------------------------------------------------------------------------------
Module RegFile(input clk, input reset, input [15:0] instruc_in, output reg [15:0] op1, output reg [15:0] op2, output reg [3:0] opcode);

reg[15:0] register [15:0];
	always@(posedge clk or negedge reset)
		if




--------------------------------------------------------------------------------------------------------------------------------
Module comparator(
input in1, in2;
Output R_out)
Begin
	if(in1 == in2)
		R_out = 1;
	Else
		R_out = 0;
end
Endmodule
-------------------------------------------------------------------------------------------------------------------------------
module adder(input[7:0] addr_in, input [3:0] constant, output [7:0] addr_out);
	assign addr_out = addr_in + constant;
endmodule
