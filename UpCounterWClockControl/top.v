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
    input top_port_en,                      // Enable
    input top_port_sel,                     // Select UCB or UCH
    input top_port_idp,                     // Decimal Point
//    input top_port_sr,                      // Shift or Rotate
    input [4:0] top_port_clk_factor,
//    input [1:0] top_port_shift,             // # of bits to shift
//    input top_port_direction,
    output [6:0] top_port_ssd,              // Output to SSD
    output top_port_odp,                    // Output to SSD Decimal Point
    output [7:0] top_port_an,                // Output to SSD analog selector
    output [3:0] top_oport_led
);
    
    wire [3:0] top_temp_num;                // Temp variable for number
//    wire [3:0] top_temp_shifted_num;         // temp variable that has been through barrel shifter
    wire top_clk_gen_out;                   // Clock Divider Result      
    
    clock_manager clock_manager_CHIP(
        .clock_manager_clk(top_port_clk),
        .clock_manager_factor(top_port_clk_factor),
        .clock_manager_rst(0),
        .clock_manager_op_clk(top_clk_gen_out)
    );
    
    uch uchCHIP(
        .uch_clk(top_clk_gen_out),          // Clock for uch
        .uch_rst(top_port_rst),             // Reset for uch
        .uch_en(top_port_en),               // En for uch
        .uch_sel(top_port_sel),             // select for uch or ucb
        .uch_q(top_temp_num)                // Output for ssd
    );
    
    assign top_oport_led = top_temp_num; // this will be before shift
    
//    barrelShifter #(.SIZE(SIZE)) barrelShifterCHIP
//    (
//        .barrelShifter_port_input(top_temp_num),            // from uch
//        .barrelShifter_port_sr(top_port_sr),                // Shift or Rotate
//        .barrelShifter_port_shift(top_port_shift),          // # of bits to shift
//        .barrelShifter_port_direction(top_port_direction),  // Direction of shift
//        .barrelShifter_port_output(top_temp_shifted_num)    // output
//    );
    
    ssd_driver ssdCHIP(
        .ssd_driver_port_inp(top_temp_num), // Input in binary
        .ssd_driver_port_idp(top_port_idp), // Input for decimal point
        .ssd_driver_port_cc(top_port_ssd),  // Output to seven segment
        .ssd_driver_port_odp(top_port_odp), // Output to decimal point
        .ssd_driver_port_an(top_port_an)    // Output to analog 
    );

endmodule
