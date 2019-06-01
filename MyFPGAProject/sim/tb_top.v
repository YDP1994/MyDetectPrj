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
	wire enTx;
	wire overTx;
	wire enRe;
	wire overRe;
	wire beginSignal;
	wire clk_32;
	wire clk_50;
	wire clk_100;
	wire [10 : 0]fifo_data_count;
	wire fifo_rst;
	wire [9:0]counter_for_rst;
	wire rst_flag;
	wire overRST;
	wire key_state;
	wire [3:0]current_state;
	wire [3:0]next_state;
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
		.e_txd(e_txd), 
		
		.enTx(enTx), 
		.overTx(overTx), 
		.enRe(enRe), 
		.overRe(overRe), 
		.beginSignal(beginSignal), 
		.clk_32(clk_32), 
		.clk_50(clk_50), 
		.clk_100(clk_100),
		
		.fifo_data_count(fifo_data_count),
		.fifo_rst(fifo_rst),
		.key_state(key_state),
		.current_state(current_state),
		.next_state(next_state),
		.counter_for_rst(counter_for_rst),
		 .rst_flag(rst_flag),
		 .overRST(overRST)
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

