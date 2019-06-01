`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:51:30 05/27/2019 
// Design Name: 
// Module Name:    Ctrl 
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
module Ctrl(
	 input clk_100,
	 input rst_n,
	 
	 //Key Ctrl
	 input key_in,
	 output reg temp_led,
	 output reg beginSignal,
	 
	 //Tx Ctrl
	 input  overTx,
	 output reg enTx,
	 
	 //Re Ctrl
	 input  overRe,
	 output reg enRe,
	 
	 //RST Ctrl
	 output reg fifo_rst,

	 output reg key_state,
	 output reg [3:0] current_state,
	 output reg [3:0] next_state,
	 
	 output reg [9:0]counter_for_rst,
	 output reg rst_flag,
	 output reg overRST
    );

//Key Ctrl Code
reg [19:0]counter_for_key;
reg key_scan;
	always@(posedge clk_100 or negedge rst_n)
	begin
		if(!rst_n)
			counter_for_key <= 20'd0;
		else
			begin
//				if(counter_for_key == 20'd999_999)begin
				if(counter_for_key == 20'd5)begin
					counter_for_key <= 20'd0;
					key_scan <= key_in;
				end
				else
					counter_for_key <= counter_for_key +20'b1;
			end
	end
	
reg key_scan_r;
	always@(posedge clk_100)
		key_scan_r <= key_scan;
		
wire flag_key = key_scan_r & (!key_scan);

//	Process-Control
//reg key_state;			//1:on	0:off
	always@(posedge clk_100 or negedge rst_n)
	begin
		if(!rst_n) begin
			temp_led <= 1'b1;
			key_state <= 1'b0;
		end
		else
			if(flag_key) begin
				temp_led <= !temp_led;
				key_state <= !key_state;
			end
	end

//三段式状态机
parameter NO_KEY_PRESSED = 4'b0001; 
parameter RST = 4'b0010;
parameter TX = 4'b0100; 
parameter RE = 4'b1000; 

//reg [3:0] current_state, next_state; // 现态、次态
//reg rst_flag;
//reg overRST;

	always@(posedge clk_100 or negedge rst_n)
	begin
		if(!rst_n)
			current_state <= NO_KEY_PRESSED;
		else 
			current_state <= next_state;
	end
	
	always@(current_state or key_state or overTx or overRe or overRST)
	begin
		next_state = NO_KEY_PRESSED;
		
		case(current_state)
			NO_KEY_PRESSED:
			begin
				if(key_state)
					next_state = RST;
				else
					next_state = NO_KEY_PRESSED;
			end
			
			RST:
			begin
				if(key_state) begin
					if(overRST)
						next_state = TX;
					else
						next_state = RST;
				end
				else
					next_state = NO_KEY_PRESSED;
			end	
			
			TX:
			begin
				if(key_state) begin
					if(overTx)
						next_state = RE;
					else
						next_state = TX;
				end
				else
					next_state = NO_KEY_PRESSED;
			end
			
			RE:
			begin
				if(key_state) begin
					if(overRe)
						next_state = NO_KEY_PRESSED;
					else
						next_state = RE;
				end
				else
					next_state = NO_KEY_PRESSED;	
			end
		endcase
	end

	always@(posedge clk_100 or negedge rst_n)
	begin
		if(!rst_n) begin
			enTx <= 1'b0;
			enRe <= 1'b0;
			beginSignal <= 1'b0;
			rst_flag <= 1'b0;
		end
		else begin 
			case(next_state)
				NO_KEY_PRESSED:
				begin
					enTx <= 1'b0;
					enRe <= 1'b0;
					beginSignal <= 1'b0;
					rst_flag <= 1'b0;
				end
				
				RST:
				begin
					enTx <= 1'b0;
					enRe <= 1'b0;
					beginSignal <= 1'b0;
					rst_flag <= 1'b1;
				end
				
				
				TX:
				begin
					enTx <= 1'b1;
					enRe <= 1'b0;
					beginSignal <= 1'b1;
					rst_flag <= 1'b0;
				end
				
				RE:
				begin
					enTx <= 1'b0;
					enRe <= 1'b1;
					beginSignal <= 1'b1;
					rst_flag <= 1'b0;
				end
				
				default:
				begin
					enTx <= 1'b0;
					enRe <= 1'b0;
					beginSignal <= 1'b0;
					rst_flag <= 1'b0;
				end
			endcase
		end
	end

//RST状态下的计数器
//reg [9:0]counter_for_rst;
	always@(posedge clk_100 or negedge rst_n)
	begin
		if(!rst_n) begin
			fifo_rst <= 1'b0;
			counter_for_rst <= 10'd0;
			overRST <= 1'b0;
		end
		else if(rst_flag) begin
			if(counter_for_rst == 10'd1000) begin
				counter_for_rst <= 10'd0;
				overRST <= 1'b1;
			end
			else if(counter_for_rst > 10'd100 && counter_for_rst < 10'd200) begin
				counter_for_rst <= counter_for_rst +10'd1;
				fifo_rst <= 1'b1;
			end
			else begin
				counter_for_rst <= counter_for_rst +10'd1;
				fifo_rst <= 1'b0;
			end
		end
		else begin
			fifo_rst <= 1'b0;
			counter_for_rst <= 10'd0;
			overRST <= 1'b0;
		end
	end
	
endmodule
