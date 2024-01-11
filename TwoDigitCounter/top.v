`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Andres R
// 
// Create Date: 09/30/2023 12:21:23 PM
// Design Name: 
// Module Name: top.v
// Project Name: Counter
// Target Devices: Nexys A7
// Tool Versions: 
// Description: Double digit counter
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top #(parameter SIZE=4)(            // # of bits
    input top_port_clk,                     // System Clock 100 Mhz
    input top_port_rst,                     // Reset
    input [4:0] top_port_clk_factor,
    input top_port_clk_rst,
    output [6:0] top_port_ssd,              // Output to SSD
    output [7:0] top_port_an                // Output to SSD analog selector
    );
     
wire [3:0] top_temp_second_num;
wire [3:0] top_temp_first_num;              // Temp variable for number
wire top_clk_gen_out;                       // Clock Divider Result  
    
clock_manager clock_manager_CHIP(
    .clock_manager_clk(top_port_clk),
    .clock_manager_factor(top_port_clk_factor),
    .clock_manager_rst(top_port_clk_rst),
    .clock_manager_op_clk(top_clk_gen_out)
);
          
twoDigitCounter twoDigitCounterCHIP(
    .twoDigitCounter_clk(top_clk_gen_out),
    .twoDigitCounter_rst(top_port_rst),
    .twoDigitCounter_clk_rst(top_port_clk_rst),
    .twoDigitCounter_first_num(top_temp_first_num),
    .twoDigitCounter_second_num(top_temp_second_num)
    );

ssd_manager ssd_manager_chip(
    .ssd_manager_clk(top_port_clk),                // Clock signal
    .ssd_manager_port_display1(top_temp_first_num),   
    .ssd_manager_port_display2(top_temp_second_num),
    .ssd_driver_port_cc(top_port_ssd),   
    .ssd_manager_oport_anode_control(top_port_an)  
);
    
endmodule
