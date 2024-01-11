`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/21/2023 10:32:37 PM
// Design Name: 
// Module Name: uhbs
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

module uhbs(
    input uhbs_clk,                              // Clock for uhbs
    input uhbs_rst,                              // Reset for uhbs
    input uhbs_sel,                               // En for uhbs
    output [3:0] uhbs_q                          // Output for ssd
    );
    
    wire [3:0] ubc_temp_q;
    wire [3:0] uhc_temp_q;
    
    ubc ubc_chip(
        .ubc_clk(uhbs_clk),                              // Clock for ubc
        .ubc_rst(uhbs_rst),                              // Reset for ubc
        .ubc_en(uhbs_sel),                               // En for ubc
        .ubc_q(ubc_temp_q)                          // Output for ssd
    );    
    
        uhc uhc_chip(
        .uhc_clk(uhbs_clk),                              // Clock for ubc
        .uhc_rst(uhbs_rst),                              // Reset for ubc
        .uhc_en(~uhbs_sel),                               // En for ubc
        .uhc_q(uhc_temp_q)                          // Output for ssd
    );  
    
     MPnx1 #(.SIZE(4)) MPCHIP   
    (
        .MPnx1_i0(uhc_temp_q),
        .MPnx1_i1(ubc_temp_q),
        .MPnx1_sel(uhbs_sel),
        .MPnx1_p(uhbs_q)
    );
endmodule
