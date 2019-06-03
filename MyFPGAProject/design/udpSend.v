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
		
			input  wire [7:0]     fifo_data,		                        //FIFO������8bit����
			input  wire [10:0]    fifo_data_count,		                  //FIFO�е���������
		   output wire           fifo_rd_en,                           //FIFO��ʹ�� 
		
			input  wire [15:0]    tx_data_length,                       //����IP�������ݳ���/
			input  wire [15:0]    tx_total_length                       //����IP�����ܳ���/

);


    

wire	[31:0] crcnext;
wire	[31:0] crc32;
wire	crcreset;
wire	crcen;


//IP frame����
Send Send_inst(
	.clk                     (e_rxc),
	.txen                    (e_txen),
	.txer                    (e_txer),
	.dataout                 (e_txd),
	
	.datain                  (fifo_data),
	.fifo_data_count         (fifo_data_count),     //FIFO�е���������
   .fifo_rd_en              (fifo_rd_en),          //FIFO��ʹ�� 	
	
	
	.crc                     (crc32),
	.crcen                   (crcen),
	.crcre                   (crcreset),
	.tx_state                (),
	.tx_data_length          (tx_data_length),
	.tx_total_length         (tx_total_length)

	);
	
//crc32У��
crc crc_inst(
	.Clk(e_rxc),
	.Reset(crcreset),
	.Enable(crcen),
	.Data_in(e_txd),
	.Crc(crc32),
	.CrcNext(crcnext));
	
endmodule

