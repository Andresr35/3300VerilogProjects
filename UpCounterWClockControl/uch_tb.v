`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/30/2023 10:42:32 AM
// Design Name: 
// Module Name: uch_tb
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
 `define clock_period 10
 `define iterations 20

module uch_tb();
    reg uch_clk_tb;                              // Clock for uch
    reg uch_rst_tb;                              // Reset for uch
    reg uch_en_tb;                               // En for uch
    reg uch_sel_tb;                               // select for uch or ucb
    wire [3:0] uch_q_tb;                         // Output for ssd
    
    /////////////////CLOCK/////////////////////////
    initial
        begin
            uch_clk_tb = 1;
        end
    always
        begin
            #(`clock_period/2) uch_clk_tb = ~uch_clk_tb;
        end
    //////////////////END CLOCK////////////////////
    
    uch uch_TEST(
        .uch_clk(uch_clk_tb),                              
        .uch_rst(uch_rst_tb),                              
        .uch_en(uch_en_tb),                               
        .uch_sel(uch_sel_tb),                              
        .uch_q(uch_q_tb)                         
    );

    initial
        begin 
            uch_rst_tb = 1;                              
            uch_en_tb = 1;
            uch_sel_tb = 0;
            #(`clock_period)
            uch_rst_tb = 0;                              
            uch_en_tb = 1;
            #((`clock_period)*(`iterations))
            uch_sel_tb = 1;
            #((`clock_period)*(`iterations))
            
            #60
        $finish;
        end
endmodule
