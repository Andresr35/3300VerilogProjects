`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Andres R
// 
// Create Date: 09/30/2023 12:21:23 PM
// Design Name: UCH+UCB Counter with SSD and Clock Divider
// Module Name: top.v
// Project Name: Counter
// Target Devices: Nexys A7
// Tool Versions: 
// Description: Counter with switch mode that uses SSD and clock divider
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top #(parameter SIZE=4)(            // # of bits
    input top_port_clk,                     // System Clock
    input top_port_rst,                     // Reset
    input top_port_sel,                     // Select UCB or UCH
    input top_port_idp,                     // Decimal Point
    input [4:0] top_port_clk_factor,
    input top_port_clk_rst,
    input top_port_dir_sel,
    output [6:0] top_port_ssd,              // Output to SSD
    output top_port_odp,                    // Output to SSD Decimal Point
    output [7:0] top_port_an                // Output to SSD analog selector
    );
    
    wire [3:0] top_temp_dc_num;                // Temp variable for number
    wire [3:0] top_temp_uc_num;
    wire [3:0] top_temp_final_num;
    
    wire top_clk_gen_out;                   // Clock Divider Result      
    
    clock_manager clock_manager_CHIP(
        .clock_manager_clk(top_port_clk),
        .clock_manager_factor(top_port_clk_factor),
        .clock_manager_rst(top_port_clk_rst),
        .clock_manager_op_clk(top_clk_gen_out)
    );
    
    dhbs dhbsCHIP(
        .dhbs_clk(top_clk_gen_out),                              // Clock for dhbs
        .dhbs_rst(top_port_rst),                              // Reset for dhbs
        .dhbs_sel(top_port_sel),                               // En for dhbs
        .dhbs_q(top_temp_dc_num)                          // Output for ssd
    );
    
    uhbs uhbs_chip(
        .uhbs_clk(top_clk_gen_out),                              // Clock for uch
        .uhbs_rst(top_port_rst),                              // Reset for uch
        .uhbs_sel(top_port_sel),                              // select for uch or ucb
        .uhbs_q(top_temp_uc_num) 
    );
    
     MPnx1 #(.SIZE(4)) MPCHIP   
    (
        .MPnx1_i0(top_temp_dc_num),
        .MPnx1_i1(top_temp_uc_num),
        .MPnx1_sel(top_port_dir_sel),
        .MPnx1_p(top_temp_final_num)
    );
    
    ssd_driver ssdCHIP(
        .ssd_driver_port_inp(top_temp_final_num), // Input in binary
        .ssd_driver_port_idp(top_port_idp), // Input for decimal point
        .ssd_driver_port_cc(top_port_ssd),  // Output to seven segment
        .ssd_driver_port_odp(top_port_odp), // Output to decimal point
        .ssd_driver_port_an(top_port_an)    // Output to analog 
    );

endmodule
