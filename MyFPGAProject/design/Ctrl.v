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
	 
	 //Tx Ctrl
	 input  overTx,
	 output enTx
    );

//Key Ctrl Code
reg [19:0]counter_for_key;
reg key_scan;
	always@(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			counter_for_key <= 20'd0;
		else
			begin
				if(counter_for_key == 20'd999_999)begin
					counter_for_key <= 20'b0;
					key_scan <= key_in;
				end
				else
					counter_for_key <= counter_for_key +20'b1;
			end
	end
	
reg key_scan_r;
	always@(posedge clk)
		key_scan_r <= key_scan;
		
wire flag_key = key_scan_r & (!key_scan);

//	Process-Control
reg state;			//1:on	0:off
reg temp_led;
	always@(posedge clk or negedge rst_n)
	begin
		if(!rst_n) begin
			temp_led <= 1'b1;
			state <= 1'b0;
		end
		else
			if(flag_key) begin
				temp_led <= !temp_led;
				state <= !state;
			end
	end

//三段式状态机
parameter NO_KEY_PRESSED = 6'b000_001; // 没有按键按下 
parameter TX = 6'b000_010; // 扫描第0行 
parameter RE = 6'b000_100; // 扫描第1行
parameter SCAN_row2 = 6'b001_000; // 扫描第2行 
parameter SCAN_row3 = 6'b010_000; // 扫描第3行 
parameter KEY_PRESSED = 6'b100_000; // 有按键按下

reg [5:0] current_state, next_state; // 现态、次态

	always@(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			current_state <= NO_KEY_PRESSED;
		else 
			current_state <= next_state;
	end
	
	always@(current or state)
	begin
		next_state = NO_KEY_PRESSED;
		
		case(current_state)
			NO_KEY_PRESSED:
			begin
				if(state)
					next_state = TX;
				else
					next_state = NO_KEY_PRESSED;
			end
			
			TX:
			begin
				
			end
		endcase
	end

	always@(posedge clk or negedge rst_n)
	begin
		if(!rst_n) begin
			enTx <= 1'b0;
		end
		else begin 
			case(next_state):
				NO_KEY_PRESSED: ;
				
				TX:
				begin
					enTx <= 1'b1;
				end
				
				RE:;
			endcase
		end
	end
	



endmodule
