`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/09/2023 03:18:11 AM
// Design Name: 
// Module Name: uch
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module uch(
    input uch_clk,
    input uch_rst,
    input uch_en,
    output reg [3:0] uch_out
    );
    
 initial
    uch_out = 0;
always@(posedge uch_clk) begin:UCH_OP
    if(uch_rst) uch_out<= 0;
    else if (uch_en) uch_out <= uch_out+1;
    
    
end
endmodule
