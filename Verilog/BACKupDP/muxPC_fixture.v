`include "muxPC.v"
module muxPC_fixture;

reg [7:0] PCAdderAddr, BranchAddr;
reg PCSRC;
wire [7:0] muxPCOut;

initial $monitor("PCSRC = %b, PCAdderAddr = %h, BranchAddr = %h, muxPCOut = %h",PCSRC, PCAdderAddr, BranchAddr, muxPCOut);

muxPC mPC(PCSRC, PCAdderAddr, BranchAddr , muxPCOut);
initial 
	begin
		PCSRC = 1'b1; PCAdderAddr = 8'h0F;  BranchAddr = 8'hF0;
	#10	PCSRC = 1'b0;
	#10	PCSRC = 1'b1; PCAdderAddr = 8'h55;  BranchAddr = 8'h44;
	#10	PCSRC = 1'b0;
	#10	PCSRC = 1'b1; PCAdderAddr = 8'h00;  BranchAddr = 8'hFF;
	#10 	PCSRC = 1'b0;
	end 
initial
	begin
		#70 $finish;
	end
endmodule

