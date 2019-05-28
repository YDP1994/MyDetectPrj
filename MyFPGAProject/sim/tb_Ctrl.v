`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   09:56:35 05/28/2019
// Design Name:   Ctrl
// Module Name:   E:/MyTangCeProject/MyFPGAProject/sim/tb_Ctrl.v
// Project Name:  MyFPGAProject
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Ctrl
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_Ctrl;

	// Inputs
	reg clk_100;
	reg rst_n;
	reg key_in;
	reg overTx;
	reg overRe;

	// Outputs
	wire temp_led;
	wire enTx;
	wire enRe;

	// Instantiate the Unit Under Test (UUT)
	Ctrl uut (
		.clk_100(clk_100), 
		.rst_n(rst_n), 
		.key_in(key_in), 
		.temp_led(temp_led), 
		.overTx(overTx), 
		.enTx(enTx), 
		.overRe(overRe), 
		.enRe(enRe)
	);

	initial begin
		// Initialize Inputs
		clk_100 = 0;
		rst_n = 0;
		key_in = 0;
		overTx = 0;
		overRe = 0;

		// Wait 100 ns for global reset to finish
		#100;
      rst_n = 1;
		// Add stimulus here
		
		#20;
		key_in = 1;
		#200;
		key_in = 0;
		
		#200;
		overTx = 1;
		#20;
		overTx = 0;
		
	end
      
	always #10 clk_100=~clk_100;
endmodule

