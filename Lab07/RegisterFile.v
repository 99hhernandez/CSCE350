module RegisterFile(BusA, BusB, BusW, RA, RB, RW, RegWr, Clk);
	output [63:0] BusA;
	output [63:0] BusB;
	input [63:0] BusW;
	input [4:0] RA, RB, RW;
	input RegWr, Clk;
	
	reg [63:0] registers[31:0];
	integer i;
	
	initial begin								// initializing all register values to 0
		for(i = 0; i < 32; i = i + 1)
		begin
			registers[i] <= 0;
		end
	end
	
	assign #2 BusA = registers[RA];
	assign #2 BusB = registers[RB];
	
	always@ (negedge Clk) begin						// changes at the negative (falling) clock edge
		if(RegWr) begin
			if(RW != 31) begin					// cant let user change Register 31
				registers[RW] <= #3 BusW;
			end
		end
	end

endmodule
