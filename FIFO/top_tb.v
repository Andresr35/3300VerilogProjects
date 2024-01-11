`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:Andres Ruiz 
// 
// Create Date: 09/30/2023 02:42:14 PM
// Design Name: Lab 6
// Module Name: top
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

 `define clk_per 10
 `define iterations 100_000_00

module top_tb();
    reg top_port_clk_tb;                     // System Clock
    reg top_port_rst_tb;                     // Reset
    reg top_port_w_tb;
    reg top_port_r_tb;
    reg [3:0] top_input_tb;
    wire top_port_full_tb;
    wire top_port_empty_tb;
    wire [6:0] top_port_ssd_tb;              // Output to SSD
    reg [7:0] top_port_an_tb;                // Output to SSD analog selector
    
    /////////////////CLOCK/////////////////////////
    initial
        begin
            top_port_clk_tb = 1;
        end
    always
        begin
            #(`clk_per/2) top_port_clk_tb = ~top_port_clk_tb;
        end
    //////////////////END CLOCK////////////////////

    top top_test(
    .top_port_clk(top_port_clk_tb),                     // System Clock
    .top_port_rst(top_port_rst_tb),                     // Reset
    .top_port_w(top_port_w_tb),
    .top_port_r(top_port_r_tb),
    .top_input(top_input_tb),
    .top_port_full(top_port_full_tb),
    .top_port_empty(top_port_empty_tb),
    .top_port_ssd(top_port_ssd_tb),              // Output to SSD
    .top_port_an()                // Output to SSD analog selector
    );
    
    initial
        begin 
            top_port_an_tb = 0;
            top_port_rst_tb = 0;                              
            top_input_tb = 4;
            top_port_r_tb = 0;
            top_port_w_tb = 1;
            #(`clk_per*100000)
            #60
        $finish;
        end
endmodule    

