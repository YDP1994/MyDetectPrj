`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:14:35 05/27/2019 
// Design Name: 
// Module Name:    Top 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Top(
    input clk,            //fpga clock
	 input rst_n,
	 
	 output daclk,
    output [7:0] dadata,       //DA data
	 
	 output adclk,
	 input [7:0] addata        //AD data
    );


wire clk_32;
wire clk_50;
wire clk_100;

assign daclk=clk_100;
assign adclk=clk_32;

  pllClock MyClock
   (// Clock in ports
    .CLK_IN1(CLK_IN1),      // IN
    // Clock out ports
    .CLK_OUT1(clk_32),     // OUT
    .CLK_OUT2(clk_50),     // OUT
    .CLK_OUT3(clk_100),     // OUT
    // Status and control signals
    .RESET(1'b0),// IN
    .LOCKED());      // OUT

endmodule
