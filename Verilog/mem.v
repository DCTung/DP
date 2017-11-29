module mem(
	   input clk, reset, MemWrite, MemRead,
	   input [7:0] addr_in,
	   input [15:0] data_in,
	   output reg [15:0] data_out);
parameter size = 98;
reg [15:0] m [size:0];

always@(posedge clk or negedge reset)
	if(reset)
	begin
		data_out <= 16'b0;
		m[8'h00] <= 16'h2BCD;
		m[8'h02] <= 16'h0000;
		m[8'h04] <= 16'h1234;
		m[8'h06] <= 16'hDEAD;
		m[8'h08] <= 16'hBEEF;
		for(i = 8'h10; i < size; i = i + 1)
			m[i] <= 16'h0000;
	end
	else if(MemRead && MemWrite)
		data_out <= m[addr_in];
		m[addr_in] <=  
	else if(MemWrite)
		m[addr_in] <= data_in;
	end
endmodule
		
		
