`include "mux2to1.v"
module mux2to1_fixture;

reg [7:0] nojump_addr, jump_addr;
reg select;
wire [7:0] addr_out;

initial $monitor("select = %b, nojump_addr = %h, jump_addr = %h, addr_out = %h",select, nojump_addr, jump_addr, addr_out);

mux2to1 m1(select, nojump_addr, jump_addr , addr_out);
initial 
	begin
		select = 1'b1; nojump_addr = 8'h0F;  jump_addr = 8'hF0;
	#10	select = 1'b0;
	#10	select = 1'b1; nojump_addr = 8'h55;  jump_addr = 8'h44;
	#10	select = 1'b0;
	#10	select = 1'b1; nojump_addr = 8'h00;  jump_addr = 8'hFF;
	#10 	select = 1'b0;
	end 
initial
	begin
		#70 $finish;
	end
endmodule

