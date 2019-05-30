`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:15:41 05/27/2019 
// Design Name: 
// Module Name:    Re 
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
module Re(
	 input clk_32,
	 input rst_n,
	 
	 //Internet Ctrl
	 output e_reset,	
    output e_mdc,                      //MDIO的时钟信号，用于读写PHY的寄存器
	 inout  e_mdio,                     //MDIO的数据信号，用于读写PHY的寄存器	
            
	 input  e_rxc,                      //125Mhz ethernet gmii rx clock\

	 input  e_txc,                      //25Mhz ethernet mii tx clock         
	 output e_gtxc,                     //25Mhz ethernet gmii tx clock  
	 output e_txen,                     //GMII 发送数据有效信号	
	 output e_txer,                     //GMII 发送数据错误信号					
	 output [7:0] e_txd,	                      //GMII 发送数据 	
		
	 
	 //Re Ctrl
	 input  enADC,
	 input  [7:0] addata        //AD data
    );


assign e_gtxc=e_rxc;	 
assign e_reset = 1'b1; 

reg [7:0] ad_data;
always @(posedge clk_32)
begin
	if(!rst_n)
      ad_data <= 8'd0;  
	else if(enADC)
		ad_data <= addata; 
	else 
		ad_data <= 8'd0;  
end

	//////////////////// DAC FIFO/////////////////// 
wire [10 : 0] fifo_data_count;
wire [7:0] fifo_data;
wire fifo_rd_en;
wire fifo_full;
wire fifo_empty;
	myFIFO myFIFO_inst (
	  .rst                      (fifo_rst),   // input rst
	  //fifo_rst是一切都结束了，就rst一下
	  .wr_clk                   (clk_32),                        // input wr_clk
	  .din                      (ad_data),                       // input [7 : 0] din
	  .wr_en                    (fifo_wr_en),                    // input wr_en
	  //fifo_wr_en是开始发送了，就设置1
	  
	  .rd_clk                   (e_rxc),                         // input rd_clk
	  .rd_en                    (fifo_rd_en),                    // input rd_en
	  .dout                     (fifo_data),                     // output [7 : 0] dout
	  .full                     (fifo_full),                     // output full
	  .empty                    (fifo_empty),                    // output empty
	  .rd_data_count            (fifo_data_count)                // output [10 : 0] rd_data_count
	);


	/////////////////udp发送和接收程序/////////////////// 
	udpSend udpSend_inst(
		.e_rxc                   (e_rxc),
		.e_txen                  (e_txen),
		.e_txd                   (e_txd),
		.e_txer                  (e_txer),		
		
		.fifo_data               (fifo_data),           //FIFO读出的8bit数据/
		.fifo_data_count         (fifo_data_count),     //FIFO中的数据数量
		.fifo_rd_en              (fifo_rd_en),          //FIFO读使能 
		
		.tx_total_length         (16'd1052),            //发送IP包的总长度/
		.tx_data_length          (16'd1032)             //发送IP包的数据长度/		

		);
	
	
endmodule
