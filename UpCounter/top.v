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


module top #(parameter SIZE=27)(            // Clock Divider Factor
    input top_port_clk,                     // System Clock
    input top_port_rst,                     // Reset
    input top_port_en,                      // Enable
    input top_port_sel,                     // Select UCB or UCH
    input top_port_idp,                     // Decimal Point
    output [6:0] top_port_ssd,              // Output to SSD
    output top_port_odp,                    // Output to SSD Decimal Point
    output [7:0] top_port_an                // Output to SSD analog selector
);
    
    wire [3:0] top_temp_num;                // Temp variable for number
    wire top_clk_gen_out;                   // Clock Divider Result      

    clk_gen #(.SIZE(SIZE)) clk_gen_CHIP(    // CLK Divider   
        .clk_gen_fsys(top_port_clk),        // System Clock
        .clk_gen_rst(top_port_rst),         // Top Reset
        .clk_gen_out(top_clk_gen_out)       // Output Frequency
    );
    
    uch uchCHIP(
        .uch_clk(top_clk_gen_out),          // Clock for uch
        .uch_rst(top_port_rst),             // Reset for uch
        .uch_en(top_port_en),               // En for uch
        .uch_sel(top_port_sel),             // select for uch or ucb
        .uch_q(top_temp_num)                // Output for ssd
    );
    
    ssd_driver ssdCHIP(
        .ssd_driver_port_inp(top_temp_num), // Input in binary
        .ssd_driver_port_idp(top_port_idp), // Input for decimal point
        .ssd_driver_port_cc(top_port_ssd),  // Output to seven segment
        .ssd_driver_port_odp(top_port_odp), // Output to decimal point
        .ssd_driver_port_an(top_port_an)    // Output to analog 
    );

endmodule
