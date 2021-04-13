`timescale 1ns / 1ps
`define STRLEN 32
module NextPCLogicTest_v;

	task passTest;
		input [63:0] actualOut, expectedOut;
		input [`STRLEN*8:0] testType;
		inout [7:0] passed;
		
		if(actualOut == expectedOut) begin $display ("%s passed", testType); passed = passed + 1; end
		else $display ("%s failed: %d should be %d", testType, actualOut, expectedOut);
	endtask
	
	task allPassed;
		input [7:0] passed;
		input [7:0] numTests;
		
		if(passed == numTests) $display ("All tests passed");
		else $display("Some tests failed");
	endtask
	
	//Inputs
	reg [63:0] CurrentPC, SignExtImm64;
	reg Branch, ALUZero, Uncondbranch;
	reg [7:0] passed;
	reg [7:0] numTests;
	
	//Outputs
	wire [63:0] NextPC;
	
	initial begin
      //Dump all wire/reg values to dump file
      $dumpfile("NextPCLogicTest.vcd");
      $dumpvars(0,NextPCLogicTest_v);
	end

	//Instantiate the Unit Under Test (UUT)
	NextPClogic uut(
		.CurrentPC(CurrentPC),
		.SignExtImm64(SignExtImm64),
		.Branch(Branch),
		.ALUZero(ALUZero),
		.Uncondbranch(Uncondbranch),
		.NextPC(NextPC)
	);
	
	initial begin
		//Initialize inputs
		CurrentPC = 0;
		SignExtImm64 = 0;
		Branch = 0;
		ALUZero = 0;
		Uncondbranch = 0;
		passed = 0;
		numTests = 0;
		#3;
		
		
		{CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch} = {64'h10, 64'h0, 1'b0, 1'b0, 1'b0}; #6; passTest({NextPC}, 64'h14, "PC+4 Test", passed);
		numTests = numTests + 1;
		
		{CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch} = {64'h10, 64'h2, 1'b1, 1'b1, 1'b0}; #6; passTest({NextPC}, 64'h12, "Conditional: Take Branch Test", passed);
		numTests = numTests + 1;
		
		{CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch} = {64'h10, 64'h3, 1'b1, 1'b0, 1'b0}; #6; passTest({NextPC}, 64'h14, "Conditional: Don't Take Branch Test", passed);
		numTests = numTests + 1;
		
		{CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch} = {64'h10, 64'h4, 1'b0, 1'b0, 1'b1}; #6; passTest({NextPC}, 64'h14, "Unconditional Test", passed);
		numTests = numTests + 1;
		
		allPassed(passed, numTests);
	end
endmodule
