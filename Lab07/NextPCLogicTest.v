`timescale 1ns / 1ps
`define STRLEN 32
module NextPCLogicTest_v;

	task passTest;
		input [63:0] actualOut, expectedOut;
		input [`STRLEN*8.0] testType;
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
	reg [63:0] expectedOut;
	
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
		CurrentPC = 64'b0;
		SignExtImm64 = 64'b0;
		Branch = 1'b0;
		ALUZero = 1'b0;
		Uncondbranch = 1'b0;
		passed = 7'b0;
		numTests = 7'b0;
		#3;
		
		CurrentPC = 64'h10;
		SignExtImm64 = 64'h0;
		Branch = 1'b0;
		ALUZero = 1'b0;
		Uncondbranch = 1'b0;
		expectedOut = 64'h14;
		#4;
		passTest(NextPC, expectedOut, "PC+4 Test", passed);
		numTests = numTests + 1;
		
		CurrentPC = 64'h10;
		SignExtImm64 = 64'h2;
		Branch = 1'b1;
		ALUZero = 1'b1;
		Uncondbranch = 1'b0;
		expectedOut = 64'h18;
		#4;
		passTest(NextPC, expectedOut, "Conditional: Take Branch Test", passed);
		numTests = numTests + 1;
		
		CurrentPC = 64'h10;
		SignExtImm64 = 64'h3;
		Branch = 1'b1;
		ALUZero = 1'b0;
		Uncondbranch = 1'b0;
		expectedOut = 64'h14;
		#4;
		passTest(NextPC, expectedOut, "Conditional: Don't Take Branch Test", passed);
		numTests = numTests + 1;
		
		CurrentPC = 64'h10;
		SignExtImm64 = 64'h4;
		Branch = 1'b0;
		ALUZero = 1'b0;
		Uncondbranch = 1'b1;
		expectedOut = 64'h20;
		#4;
		passTest(NextPC, expectedOut, "Unconditional Branch Test", passed);
		numTests = numTests + 1;
		
		allPassed(passed, numTests);
	end
endmodule
