`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:27:13 05/27/2019
// Design Name:   Tx
// Module Name:   E:/MyTangCeProject/MyFPGAProject/sim/tb_Tx.v
// Project Name:  MyFPGAProject
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Tx
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_Tx;

	// Inputs
	reg rst_n;
	reg enTx;
	reg clk_100;

	// Outputs
	wire overTx;
	wire [7:0] dadata;

	// Instantiate the Unit Under Test (UUT)
	Tx uut (
		.clk_100(clk_100), 
		.rst_n(rst_n), 
		.enTx(enTx), 
		.overTx(overTx), 
		.dadata(dadata)
	);

	initial begin
		// Initialize Inputs
		rst_n = 0;
		enTx = 0;
		clk_100 = 0;

		// Wait 100 ns for global reset to finish
		#90;
      rst_n = 1; 
		
		#20;
		enTx = 1;
		// Add stimulus here

	end
   

	always #10 clk_100=~clk_100;

endmodule

