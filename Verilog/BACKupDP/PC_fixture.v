`include "PC.v"
module PC_fixture;
reg [7:0] addr_in;
wire [7:0] addr_out;

initial
	$monitor($time, " addr_in = %h, addr_out = %h ",addr_in, addr_out);
PC t1(addr_in, addr_out);

initial 
	begin
			 #20 	   	addr_in = 8'h01;
			 #20            addr_in = 8'hFF;
			 #20 		addr_in = 8'hF0;
			 #20		addr_in = 8'h0F;
			 #20		addr_in = 8'h07;
			 #20		addr_in = 8'h0A;
			 #20 		addr_in = 8'h0C;
	end
initial
	begin
		#200 $finish;
	end
endmodule
