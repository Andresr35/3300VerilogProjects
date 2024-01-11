`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/30/2023 02:42:14 PM
// Design Name: 
// Module Name: top_tb
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
 `define clk_period 0.01

module top_tb();
    reg top_clk_tb;
    reg top_clk_rst_tb;
    reg [4:0]top_port_clk_factor_tb;
    reg top_rst_tb;
    wire [6:0] top_ssd_tb;
    reg [7:0] top_an_tb;
    
    /////////////////CLOCK/////////////////////////
    initial
        begin
            top_clk_tb = 1;
        end
    always
        begin
            #(`clk_period/2) top_clk_tb = ~top_clk_tb;
        end
    //////////////////END CLOCK////////////////////

    top #(.SIZE(4)) top_test(
        .top_port_clk(top_clk_tb),
        .top_port_rst(top_rst_tb),
        .top_port_clk_factor(top_port_clk_factor_tb),
        .top_port_clk_rst(top_clk_rst_tb),
        .top_port_ssd(top_ssd_tb),
        .top_port_an()
    );
    
    initial
        begin 
            top_port_clk_factor_tb = 20;
             top_rst_tb = 1; 
             top_clk_rst_tb=0;   
             top_an_tb = 8'b11111100;                         
             #10
             top_rst_tb = 0;
            #1_000_000_000

            #60
        $finish;
        end
endmodule    

