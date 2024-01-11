`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/27/2023 08:24:29 PM
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
    input uch_clk,                              // Clock for uch
    input uch_rst,                              // Reset for uch
    input uch_sel,                              // select for uch or ucb
    output reg [3:0] uch_q                      // Output for ssd
);

wire uch_temp_nine_boolean;
wire uch_final_rst;

assign uch_temp_nine_boolean = uch_q[0] & ~uch_q[1] & ~uch_q[2] & uch_q[3]; // whether number 9 has hit or not    
assign uch_final_rst = (uch_sel?uch_temp_nine_boolean:0) | uch_rst;

initial
    uch_q <= 0;
always@(posedge uch_clk)
    begin:UCH_OP
      if(uch_final_rst)     
        uch_q =0;
      else
        uch_q <= uch_q+1;
    end
    
endmodule
