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
    input  clk,            //fpga clock
	 input  rst_n,
	 
	 //dac
	 output daclk,
    output [7:0] dadata,       //DA data
	 
	 //adc
	 output adclk,
	 input  [7:0] addata,        //AD data
	 
	 //transfer
	 output enADC,
	 
	 //key
	 input  key_in,
	 output temp_led,
	 
	 //ethernet
	 output e_reset,	
    output e_mdc,                      //MDIO的时钟信号，用于读写PHY的寄存器
	 inout  e_mdio,                     //MDIO的数据信号，用于读写PHY的寄存器	
	 input  e_rxc,                      //125Mhz ethernet gmii rx clock\   
	 output e_gtxc,                     //25Mhz ethernet gmii tx clock  
	 output e_txen,                     //GMII 发送数据有效信号	
	 output e_txer,                     //GMII 发送数据错误信号					
	 output [7:0] e_txd	                      //GMII 发送数据 	
	 
    );

//clock
wire clk_32;
wire clk_50;
wire clk_100;

//Tx
wire enTx;
wire overTx;

//Re
wire enRe;
wire overRe;
wire beginSignal;

//RST
wire fifo_rst;

assign daclk=clk_100;
assign adclk=clk_32;

assign enADC = enTx;

Tx Tx_inst (
    .clk_100(clk_100), 
    .rst_n(rst_n), 
	 
    .enTx(enTx), 
    .overTx(overTx), 
    .dadata(dadata)
    );

Ctrl Ctrl_inst (
    .clk_100(clk_100), 
    .rst_n(rst_n), 
	 
    .key_in(key_in), 
    .temp_led(temp_led),
	 .beginSignal(beginSignal),
	 
    .overTx(overTx), 
    .enTx(enTx), 
	 
    .overRe(overRe), 
    .enRe(enRe),
	 
	 .fifo_rst(fifo_rst)
    );

Re Re_inst (
    .clk_32(clk_32), 
	 .clk_100(clk_100),
    .rst_n(rst_n), 
    .e_reset(e_reset), 
    .e_rxc(e_rxc), 
    .e_gtxc(e_gtxc), 
    .e_txen(e_txen), 
    .e_txer(e_txer), 
    .e_txd(e_txd),
	 
	 .beginSignal(beginSignal),
    .enADC(enRe), 
    .addata(addata),
	 .overRe(overRe),
	 .fifo_rst(fifo_rst)
    );


pllClock pllClock_inst
   (// Clock in ports
    .CLK_IN1(clk),      // IN
    // Clock out ports
    .CLK_OUT1(clk_32),     // OUT
    .CLK_OUT2(clk_50),     // OUT
    .CLK_OUT3(clk_100),     // OUT
    // Status and control signals
    .RESET(1'b0),// IN
    .LOCKED());      // OUT

endmodule
