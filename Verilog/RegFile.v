module RegFile(
	       input clk, reset, 
	       input [15:0] instruc_in, Writedata, 
	       input RegWrite, 
		
	       output reg [15:0] op1, 
	       output reg [15:0] op2);
reg [15:0] register [15:0];
	always@(posedge clk or negedge reset)
		begin
			if(reset)
			begin
				op2 <= 16'h0000;
				op1 <= 16'h0000;
				register[1] <= 16'h0F00;
				register[2] <= 16'h0050;
				register[3] <= 16'hFF0F;
				register[4] <= 16'hF0FF;
				register[5] <= 16'h0040;
				register[6] <= 16'h6666;
				register[7] <= 16'h00FF;
				register[8] <= 16'hFF88;
				register[9] <= 16'h0000;
				register[10] <= 16'h0000;
				register[11] <= 16'h0000;
				register[12] <= 16'hCCCC;
				register[13] <= 16'h0002;
				register[14] <= 16'h0000;
				register[15] <= 16'h0000;
				register[16] <= 16'h0000;
			end
			else if(instruc_in[15:12] == 4'b1111) // Type A opcode
			begin	op1 <= register [instruc_in [11:8]];
        			op2 <= register [instruc_in [7:4]];
			end
			//begin
				//	if(instruct_in[3:0] != 4'b0100 | instruct_in[3:0] != 4'b0101) // Type A funct code doesnt not require R15
			//			R15 <= 1'b0;	
			//	else
			//		R15 <= 1'b1;
			//	end

		begin
			if(RegWrite) // if Write is 1
				register[instruc_in[11:8]] <= Writedata [15:0];
		end
	end
 endmodule
