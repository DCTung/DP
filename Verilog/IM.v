module IM (
	input [7:0] addr_in, 
	output reg [7:0] addr_out, 
	output reg [15:0] instruc_out);
	reg [15:0] mem[254:0];
	always@(*)
		begin
	         mem[8'h00] = 16'hF120;
	         mem[8'h02] = 16'hF121;
	         mem[8'h04] = 16'h93FF;
		 mem[8'h06] = 16'h834C;
	         mem[8'h08] = 16'hF564;
		 mem[8'h0A] = 16'hF155;
		 mem[8'h0C] = 16'hFFF1;
		 mem[8'h0E] = 16'hF487;
		 mem[8'h10] = 16'hF468;
		 mem[8'h12] = 16'h9402;
		 mem[8'h14] = 16'hA696;
		 mem[8'h16] = 16'hB696;
		 mem[8'h18] = 16'hC696;
		 mem[8'h1A] = 16'h6704;
		 mem[8'h1C] = 16'hFB10;
		 mem[8'h1E] = 16'h5705;
		 mem[8'h20] = 16'hFB20;
		 mem[8'h22] = 16'h4702;
		 mem[8'h24] = 16'hF110;
		 mem[8'h26] = 16'hF110;
		 mem[8'h28] = 16'hC890;
		 mem[8'h2A] = 16'hF886;
		 mem[8'h2C] = 16'hD892;
		 mem[8'h30] = 16'hFCC0;
		 mem[8'h32] = 16'hFDD1;
		 mem[8'h34] = 16'hFCD0;
		 mem[8'h36] = 16'hEFFF;
		 mem[8'h38] = 16'h0000;
	
		instruc_out = mem[addr_in];
		addr_out = addr_in;
	end
endmodule
