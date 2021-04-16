`timescale 1ns / 1ps
`define STRLEN 32
module ALUTest_v;

	task passTest;
		input [64:0] actualOut, expectedOut;
		input [`STRLEN*8:0] testType;
		inout [7:0] passed;
	
		if(actualOut == expectedOut) begin $display ("%s passed", testType); passed = passed + 1; end
		else $display ("%s failed: %x should be %x", testType, actualOut, expectedOut);
	endtask
	
	task allPassed;
		input [7:0] passed;
		input [7:0] numTests;
		
		if(passed == numTests) $display ("All tests passed");
		else $display("Some tests failed");
	endtask

	// Inputs
	reg [63:0] BusA;
	reg [63:0] BusB;
	reg [3:0] ALUCtrl;
	reg [7:0] passed;

	// Outputs
	wire [63:0] BusW;
	wire Zero;

	// Instantiate the Unit Under Test (UUT)
	ALU uut (
		.BusW(BusW), 
		.Zero(Zero), 
		.BusA(BusA), 
		.BusB(BusB), 
		.ALUCtrl(ALUCtrl)
	);

	initial begin
		// Initialize Inputs
		BusA = 0;
		BusB = 0;
		ALUCtrl = 0;
		passed = 0;

                // Here is one example test vector, testing the ADD instruction:
		{BusA, BusB, ALUCtrl} = {64'h1234, 64'hABCD0000, 4'h2}; #40; passTest({Zero, BusW}, 65'h0ABCD1234, "ADD 0x1234,0xABCD0000", passed);
		//Reformate and add your test vectors from the prelab here following the example of the testvector above.
		
		//AND
		{BusA, BusB, ALUCtrl} = {64'h12344321, 64'h1234, 4'h0}; #40; passTest({Zero, BusW}, 65'h000000220, "AND 0x12344321,0x1234", passed);
		{BusA, BusB, ALUCtrl} = {64'h1234, 64'h1234, 4'h0}; #40; passTest({Zero, BusW}, 65'h000001234, "AND 0x1234,0x1234", passed);
		{BusA, BusB, ALUCtrl} = {64'hFFFF, 64'h1111, 4'h0}; #40; passTest({Zero, BusW}, 65'h000001111, "AND 0xFFFF,0x1111", passed);
		//OR
		{BusA, BusB, ALUCtrl} = {64'hABCD, 64'h1234, 4'h1}; #40; passTest({Zero, BusW}, 65'h00000BBFD, "OR 0xABCD,0x1234", passed);
		{BusA, BusB, ALUCtrl} = {64'h0, 64'h0, 4'h1}; #40; passTest({Zero, BusW}, {1'h1, 64'h0}, "OR 0x0,0x0", passed);
		{BusA, BusB, ALUCtrl} = {64'hFFFF, 64'h12340000, 4'h1}; #40; passTest({Zero, BusW}, 65'h1234FFFF, "OR 0xFFFF,0x12340000", passed);	
		//ADD
		{BusA, BusB, ALUCtrl} = {64'h00, 64'h00, 4'h2}; #40; passTest({Zero, BusW}, {1'h1, 64'h0}, "ADD 0x0,0x0", passed);
		{BusA, BusB, ALUCtrl} = {64'hFFFFFFFF, 64'h0001, 4'h2}; #40; passTest({Zero, BusW}, 65'h100000000, "ADD 0xFFFFFFFF,0x1", passed);
		{BusA, BusB, ALUCtrl} = {64'h11111111, 64'h0F0F0F0F, 4'h2}; #40; passTest({Zero, BusW}, 65'h020202020, "ADD 0x11111111,0x0F0F0F0F", passed);
		//SUB
		{BusA, BusB, ALUCtrl} = {64'h0, 64'h1, 4'h6}; #40; passTest({Zero, BusW}, {1'h0, {64{1'hF}}}, "SUB 0x0,0x1", passed);
		{BusA, BusB, ALUCtrl} = {64'h1234, 64'h1234, 4'h6}; #40; passTest({Zero, BusW}, {1'h1, {64{1'h0}}}, "SUB 0x1234,0x1234", passed);
		{BusA, BusB, ALUCtrl} = {64'hABCD1234, 64'h1234, 4'h6}; #40; passTest({Zero, BusW}, 65'h0ABCD0000, "SUB 0xABCD1234,0x1234", passed);
		//PassB
		{BusA, BusB, ALUCtrl} = {64'hABCD1234, 64'h0000, 4'h7}; #40; passTest({Zero, BusW}, {1'h1, {64{1'h0}}}, "PassB 0xABCD1234,0x0", passed);
		{BusA, BusB, ALUCtrl} = {64'hABCD, 64'h1234, 4'h7}; #40; passTest({Zero, BusW}, 65'h000001234, "PassB 0xABCD,0x1234", passed);
		{BusA, BusB, ALUCtrl} = {64'hFFFF, 64'h10, 4'h7}; #40; passTest({Zero, BusW}, 65'h000000010, "PassB 0xFFFF,0x10", passed);

		allPassed(passed, 22);
	end
      
endmodule

