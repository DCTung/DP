`include "PC.v"
module PC_fixture;
reg clk, reset;
reg [7:0] addr_in;
wire [7:0] addr_out;

initial
	$monitor($time, " reset = %b, addr_in = %h, addr_out = %h ", reset, addr_in, addr_out);
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
			 #20            addr_in = 8'hFF;
			 #20 		addr_in = 8'hF0;
			 #20		addr_in = 8'h0F;
			 #20		addr_in = 8'h07;
			 #20		addr_in = 8'h0A;
			 #20 		addr_in = 8'h0C;
	reset = 1;
	end
initial
	begin
		#200 $finish;
	end
endmodule
