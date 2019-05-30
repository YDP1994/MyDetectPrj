`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:49:35 05/29/2019 
// Design Name: 
// Module Name:    udpSend 
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
module udpSend(		
			input	 wire           e_rxc,
			output wire	          e_txen,
			output wire	[7:0]     e_txd,                              
			output wire		       e_txer,		
		
			input  wire [7:0]     fifo_data,		                        //FIFO读出的8bit数据
			input  wire [10:0]    fifo_data_count,		                  //FIFO中的数据数量
		   output wire           fifo_rd_en,                           //FIFO读使能 
		
			input  wire [15:0]    tx_data_length,                       //发送IP包的数据长度/
			input  wire [15:0]    tx_total_length                       //发送IP包的总长度/

);


    

wire	[31:0] crcnext;
wire	[31:0] crc32;
wire	crcreset;
wire	crcen;


//IP frame发送
Send Send_inst(
	.clk                     (e_rxc),
	.txen                    (e_txen),
	.txer                    (e_txer),
	.dataout                 (e_txd),
	
	.datain                  (fifo_data),
	.fifo_data_count         (fifo_data_count),     //FIFO中的数据数量
   .fifo_rd_en              (fifo_rd_en),          //FIFO读使能 	
	
	
	.crc                     (crc32),
	.crcen                   (crcen),
	.crcre                   (crcreset),
	.tx_state                (),
	.tx_data_length          (tx_data_length),
	.tx_total_length         (tx_total_length)

	);
	
//crc32校验
crc crc_inst(
	.Clk(e_rxc),
	.Reset(crcreset),
	.Enable(crcen),
	.Data_in(e_txd),
	.Crc(crc32),
	.CrcNext(crcnext));
	
endmodule

