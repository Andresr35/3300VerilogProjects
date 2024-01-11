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
 `define clk_per 0.1
 `define iterations 100_0

module top_tb();
    reg top_port_clk_tb;                     // System Clock
    reg top_port_rst_tb;                     // Reset
    reg top_clk_rst_tb;
    reg top_load_tb;
    reg [15:0] top_input_tb;
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

    top #(.CLK(2)) top_test(
    .top_port_clk(top_port_clk_tb),                     // System Clock
    .top_port_rst(top_port_rst_tb),                     // Reset
    .top_clk_rst(top_clk_rst_tb),
    .top_load(top_load_tb),
    .top_input(top_input_tb),
    .top_port_ssd(top_port_ssd_tb),              // Output to SSD
    .top_port_an()                // Output to SSD analog selector
    );
    
    initial
        begin 
            top_port_an_tb=0;
            top_clk_rst_tb = 0;
            top_port_rst_tb = 1;                              
            top_load_tb = 0;
            top_input_tb = 16'h0008;
            #(`clk_per)
            top_port_rst_tb = 0;
            #((`clk_per)*(`iterations))
            top_load_tb = 1;
            #60
        $finish;
        end
endmodule    

