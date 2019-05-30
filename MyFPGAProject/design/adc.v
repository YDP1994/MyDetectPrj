`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:36:43 05/30/2019 
// Design Name: 
// Module Name:    adc 
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
module adc(
	 
    input enADC,
	 input [7:0] addata        //AD data
    );


always @(posedge clk_25)
begin
      ad_data <= addata ;  
end 

endmodule
