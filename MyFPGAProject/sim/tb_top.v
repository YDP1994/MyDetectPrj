`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:23:45 05/31/2019
// Design Name:   Top
// Module Name:   E:/MyTangCeProject/MyFPGAProject/sim/tb_top.v
// Project Name:  MyFPGAProject
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Top
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_top;

	// Inputs
	reg clk;
	reg rst_n;
	reg [7:0] addata;
	reg key_in;
	reg e_rxc;

	// Outputs
	wire daclk;
	wire [7:0] dadata;
	wire adclk;
	wire enADC;
	wire temp_led;
	wire e_reset;
	wire e_mdc;
	wire e_gtxc;
	wire e_txen;
	wire e_txer;
	wire [7:0] e_txd;
	
	// Bidirs
	wire e_mdio;

	
	// Instantiate the Unit Under Test (UUT)
	Top uut (
		.clk(clk), 
		.rst_n(rst_n), 
		.daclk(daclk), 
		.dadata(dadata), 
		.adclk(adclk), 
		.addata(addata), 
		.enADC(enADC), 
		.key_in(key_in), 
		.temp_led(temp_led), 
		.e_reset(e_reset), 
		.e_mdc(e_mdc), 
		.e_mdio(e_mdio), 
		.e_rxc(e_rxc), 
		.e_gtxc(e_gtxc), 
		.e_txen(e_txen), 
		.e_txer(e_txer), 
		.e_txd(e_txd)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst_n = 0;
		addata = 0;
		key_in = 0;
		e_rxc = 0;

		// Wait 100 ns for global reset to finish
		#100;
		rst_n = 1;
		
		// Add stimulus here
		#20;
		key_in = 1;
		addata = 8'd8;
		
		#200;
		key_in = 0;
		
		#11000000;
		key_in = 1;
		
		#200;
		key_in = 0;
		
		#2000000;
		key_in = 1;
		
		#200;
		key_in = 0;
	end
   
	always #10 clk=~clk;
	always #4 e_rxc=~e_rxc;
	
endmodule

