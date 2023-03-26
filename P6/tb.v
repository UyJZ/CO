`timescale 1ns / 1ps
module tb;

	reg clk;
	reg reset;

	// Instantiate the Unit Under Test (UUT)
	mips uut (
		.clk(clk), 
		.reset(reset)
	);

	always #1 clk = ~clk;

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 1;

		#10;
		reset = 0;
        #1000;
		$finish;
		// Add stimulus here

	end
      
endmodule

