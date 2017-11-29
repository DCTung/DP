module mem(
	   input clk, reset, MemWrite, MemRead,
	   input [7:0] addr_in,
	   input [15:0] data_in,
	   output reg [15:0] data_out);
reg [7:0] m [255:0];
integer i;
always@(posedge clk or negedge reset)
	if(reset)
	begin
		data_out <= 16'h0000;
		m[8'h00] <= 8'h2B; //m[00 - 01] = 2BCD
		m[8'h01] <= 8'hCD;

		m[8'h02] <= 8'h00; //m[02 - 03] = 0000
		m[8'h03] <= 8'h00;

		m[8'h04] <= 8'h12; //m[04 - 05] = 1234
		m[8'h05] <= 8'h34;

		m[8'h06] <= 8'hDE; //m[06 - 07] = DEAD
		m[8'h07] <= 8'hAD;

		m[8'h08] <= 8'hEF; //m[08 - 09] = BEEF;
		m[8'h09] <= 8'hEF;

		for(i = 8'h10; i < 255; i = i + 1)
			m[i] <= 16'h0000;
	end
	else if(MemRead && MemWrite)
	begin
		data_out[15:8] <= m[addr_in];		//MemRead
		data_out[7:0] <= m[addr_in + 1]; 
		m[addr_in] <=  data_in[15:8];		//MemWrite
		m[addr_in + 1] <= data_in[7:0]; 	
	end
	else if(MemRead && !MemWrite)
	begin
		data_out[15:8] <= m[addr_in];		//MemRead
		data_out[7:0] <= m[addr_in + 1]; 
	end	
	else if(!MemRead && MemWrite)
	begin
		m[addr_in] <= data_in[15:8];  		//MemWrite
		m[addr_in + 1] <= data_in[7:0]; 
	end
endmodule
		
		
