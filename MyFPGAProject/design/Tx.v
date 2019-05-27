`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:15:10 05/27/2019 
// Design Name: 
// Module Name:    Tx 
// Project Name: 
// Target Devices: 
// Tool versions: V0.1
// Description: Œ“¥ÚÀ„
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Tx(
	 input clk_100,
	 input rst_n,
	 
	 //Tx ctrl
	 input  enTx,			//1:on     0:off
	 output reg overTx,	//1:over   0:not yet
	 
	 //DAC ctrl
    output [7:0] dadata       //DA data
    );
	 
reg [8:0] rom_addr;
wire [7:0] rom_douta;

assign dadata=rom_douta;

	//DA output sin waveform
	always @(posedge clk_100 or negedge rst_n)
	begin
		if(!rst_n || !enTx) begin
			rom_addr <= 9'd0;
			overTx <= 1'b0;
		end
		else if(rom_addr == 9'd511)begin
			rom_addr <= 9'd0;
			overTx <= 1'b1;
		end
		else begin
			rom_addr <= rom_addr + 1'b1;
			overTx <= 1'b0;
		end
	end 
	
	chirpRom MyChirp (
	  .clka(clk_100), // input clka
	  .addra(rom_addr), // input [8 : 0] addra
	  .douta(rom_douta) // output [7 : 0] douta
	);

endmodule
