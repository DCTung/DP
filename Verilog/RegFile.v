module RegFile(input clk, reset, input [15:0] instruc_in, output reg [15:0] op1, output reg [15:0] op2, output reg [3:0] opcode);
reg [15:0] register [15:0];
	always@(posedge clk or negedge reset)
		begin
			if(reset)
				op1 <= 16'h0000;
				op2 <= 16'h0000;
				opcode <= 4'h2;  //4'h2 is only a placeholder
        //load preset contents here
			else if(instruc_in[15:12] == 4'b1111) // Type A
        op1 <= register [instruc_in [11:8]];
        op2 <= register [instruc_in [7:4]];
        opcode <= instruct_in[15:12];
      end
 endmodule
        
