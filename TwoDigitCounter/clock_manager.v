`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/10/2023 01:57:14 AM
// Design Name: 
// Module Name: clock_manager
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


module clock_manager(
    input clock_manager_clk,
    input [4:0] clock_manager_factor,
    input clock_manager_rst,
    output clock_manager_op_clk
    );
    
    clk_gen #(.SIZE(32)) clk_gen_chip(
    .clk_gen_fsys(clock_manager_clk),
    .clk_gen_rst(clock_manager_rst),
    .clk_gen_factor(clock_manager_factor),
    .clk_gen_out(clock_manager_op_clk)
    );
    
endmodule
