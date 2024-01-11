`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/12/2023 01:34:45 AM
// Design Name: 
// Module Name: dhbs
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


module dhbs(
    input dhbs_clk,                              // Clock for dhbs
    input dhbs_rst,                              // Reset for dhbs
    input dhbs_sel,                               // En for dhbs
    output [3:0] dhbs_q                          // Output for ssd
    );
    
    wire [3:0] dbc_temp_q;
    wire [3:0] dhc_temp_q;
    
    dbc dbc_chip(
        .dbc_clk(dhbs_clk),                              // Clock for dbc
        .dbc_rst(dhbs_rst),                              // Reset for dbc
        .dbc_en(dhbs_sel),                               // En for dbc
        .dbc_q(dbc_temp_q)                          // Output for ssd
    );    
    
        dhc dhc_chip(
        .dhc_clk(dhbs_clk),                              // Clock for dbc
        .dhc_rst(dhbs_rst),                              // Reset for dbc
        .dhc_en(~dhbs_sel),                               // En for dbc
        .dhc_q(dhc_temp_q)                          // Output for ssd
    );  
    
     MPnx1 #(.SIZE(4)) MPCHIP   
    (
        .MPnx1_i0(dhc_temp_q),
        .MPnx1_i1(dbc_temp_q),
        .MPnx1_sel(dhbs_sel),
        .MPnx1_p(dhbs_q)
    );
    
endmodule
