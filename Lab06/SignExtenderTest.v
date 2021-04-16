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
	reg [25:0] Inst;
	reg [1:0] Ctrl;
	reg [7:0] passed;

	// Outputs
	wire [63:0] Out;

	// Instantiate the Unit Under Test (UUT)
	SignExtender uut (
		.Out(Out),
		.Inst(Inst), 
		.Ctrl(Ctrl)
	);

	initial begin
		// Initialize Inputs
		Inst = 0;
		Ctrl = 0;
		passed = 0;

		//I-type
		{Inst, Ctrl} = {26'hABC, 2'h0}; #20; passTest({Out}, 64'h2, "I-type 0xABC", passed);
		{Inst, Ctrl} = {26'hFED, 2'h0}; #20; passTest({Out}, 64'h3, "I-type 0xFED", passed);
		{Inst, Ctrl} = {26'hAB98, 2'h0}; #20; passTest({Out}, 64'h2A, "I-type 0xAB98", passed);
		//D-type
		{Inst, Ctrl} = {26'hABC, 2'h1}; #20; passTest({Out}, 64'h0, "D-type 0xABC", passed);
		{Inst, Ctrl} = {26'hFED123, 2'h1}; #20; passTest({Out}, 64'hFFFFFFFFFFFFFFED, "D-type 0xFED123", passed);
		{Inst, Ctrl} = {26'hAB98, 2'h1}; #20; passTest({Out}, 64'hA, "D-type 0xAB98", passed);	
		//B
		{Inst, Ctrl} = {26'hABC, 2'h2}; #20; passTest({Out}, 64'h2AF0, "B 0xABC", passed);
		{Inst, Ctrl} = {26'hFED, 2'h2}; #20; passTest({Out}, 64'h3FB4, "B 0xFED", passed);
		{Inst, Ctrl} = {26'hFED123, 2'h2}; #20; passTest({Out}, 64'h3FB448C, "B 0xFED123", passed);
		//CBZ
		{Inst, Ctrl} = {26'hABC, 2'h3}; #20; passTest({Out}, 64'h0154, "CBZ 0xABC", passed);
		{Inst, Ctrl} = {26'hFED, 2'h3}; #20; passTest({Out}, 64'h1FC, "CBZ 0xFED", passed);
		{Inst, Ctrl} = {26'hAB98, 2'h3}; #20; passTest({Out}, 64'h1570, "CBZ 0xAB98", passed);
		
		allPassed(passed, 22);
	end
      
endmodule
