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
    output e_mdc,                      //MDIO��ʱ���źţ����ڶ�дPHY�ļĴ���
	 inout  e_mdio,                     //MDIO�������źţ����ڶ�дPHY�ļĴ���	
            
	 input  e_rxc,                      //125Mhz ethernet gmii rx clock\

	 input  e_txc,                      //25Mhz ethernet mii tx clock         
	 output e_gtxc,                     //25Mhz ethernet gmii tx clock  
	 output e_txen,                     //GMII ����������Ч�ź�	
	 output e_txer,                     //GMII �������ݴ����ź�					
	 output [7:0] e_txd,	                      //GMII �������� 	
		
	 
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
	  //fifo_rst��һ�ж������ˣ���rstһ��
	  .wr_clk                   (clk_32),                        // input wr_clk
	  .din                      (ad_data),                       // input [7 : 0] din
	  .wr_en                    (fifo_wr_en),                    // input wr_en
	  //fifo_wr_en�ǿ�ʼ�����ˣ�������1
	  
	  .rd_clk                   (e_rxc),                         // input rd_clk
	  .rd_en                    (fifo_rd_en),                    // input rd_en
	  .dout                     (fifo_data),                     // output [7 : 0] dout
	  .full                     (fifo_full),                     // output full
	  .empty                    (fifo_empty),                    // output empty
	  .rd_data_count            (fifo_data_count)                // output [10 : 0] rd_data_count
	);


	/////////////////udp���ͺͽ��ճ���/////////////////// 
	udpSend udpSend_inst(
		.e_rxc                   (e_rxc),
		.e_txen                  (e_txen),
		.e_txd                   (e_txd),
		.e_txer                  (e_txer),		
		
		.fifo_data               (fifo_data),           //FIFO������8bit����/
		.fifo_data_count         (fifo_data_count),     //FIFO�е���������
		.fifo_rd_en              (fifo_rd_en),          //FIFO��ʹ�� 
		
		.tx_total_length         (16'd1052),            //����IP�����ܳ���/
		.tx_data_length          (16'd1032)             //����IP�������ݳ���/		

		);
	
	
endmodule
