module mem(
	   input clk, reset, MemWrite, MemRead,
	   input [7:0] Memaddr_in,
	   input [15:0] data_in,
	   output reg [15:0] data_out);
reg [15:0] m [255:0];
integer i;
always@(posedge clk or negedge reset)
	if(reset)
	begin
		data_out <= 16'h0000;
		m[8'h00] <= 16'h2BCD;
		m[8'h02] <= 16'h0000;
		m[8'h04] <= 16'h1234;
		m[8'h06] <= 16'hDEAD;
		m[8'h08] <= 16'hBEEF;
		for(i = 8'h10; i < 255; i = i + 1)
			m[i] <= 16'h0000;
	end
	else if(MemRead && MemWrite)
	begin
		data_out <= m[Memaddr_in];
		m[Memaddr_in] <= data_in;
	end
	else if(MemRead && !MemWrite)
		data_out <= m[Memaddr_in];
	else if(!MemRead && MemWrite)
		m[Memaddr_in] <= data_in;
endmodule


//Contorl signal will tell us if we're loading/storing -- SE signal will be muxed in so just parse the ALUResult into the Mem
