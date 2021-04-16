module SignExtender(Out, Inst, Ctrl);
	output [63:0] Out;
	input [25:0] Inst;
	input [1:0] Ctrl;
	
	reg [63:0] Out;

	always@(Inst or Ctrl)
	begin
		if (Ctrl == 2'b00)								// I-type	
			Out <= {{52{Inst[21]}}, Inst[21:10]};
		else if (Ctrl == 2'b01)							// D-type
			Out <= {{55{Inst[20]}}, Inst[20:12]};
		else if (Ctrl == 2'b10)							// B
			Out <= {{36{Inst[25]}}, Inst[25:0], 2'b0};
		else if (Ctrl == 2'b11)							// CBZ
			Out <= {{43{Inst[23]}}, Inst[23:5], 2'b0};
	end
	
endmodule
