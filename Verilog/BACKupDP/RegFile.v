module RegFile( 
	       input [15:0] instruc_in, Writedata,
	       input [3:0] Writereg, 
	       input RegWrite, reset, 
	       output reg [15:0] op1, op2, Reg15);
integer i;
reg [15:0] register [16:1];
	always@(reset)
			begin
				register[1]  <= 16'h0F00;
				register[2]  <= 16'h0050;
				register[3]  <= 16'hFF0F;
				register[4]  <= 16'hF0FF;
				register[5]  <= 16'h0040;
				register[6]  <= 16'h6666;
				register[7]  <= 16'h00FF;
				register[8]  <= 16'hFF88;
				register[9]  <= 16'h0000;
				register[10] <= 16'h0000;
				register[11] <= 16'h0000;
				register[12] <= 16'hCCCC;
				register[13] <= 16'h0002;
				register[14] <= 16'h0000;
				register[15] <= 16'h0000;
				register[16] <= 16'h0000;	
			end
	always@(*)
			begin
				op1 = register [instruc_in [11:8]];
        			op2 = register [instruc_in [7:4]];
				Reg15 = register[15];

				if(RegWrite) // if Write is 1
					register[Writereg] = Writedata [15:0];
				//for(i = 1; i < 17; i = i + 1)
				//	$display("register[%d] = %h", i, register[i]);
			end
endmodule
