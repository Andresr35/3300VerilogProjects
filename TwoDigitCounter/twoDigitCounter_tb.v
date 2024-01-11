`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/24/2023 07:12:18 PM
// Design Name: 
// Module Name: twoDigitCounter_tb
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

module twoDigitCounter_tb();
    reg twoDigitCounter_clk_tb;
    reg twoDigitCoutner_rst_tb;
    reg twoDigitCounter_clk_rst_tb;
    wire [3:0]twoDigitCounter_first_num_tb;
    wire [3:0]twoDigitCounter_second_num_tb;
        /////////////////CLOCK/////////////////////////
    initial
        begin
            twoDigitCounter_clk_tb = 1;
        end
    always
        begin
            #(`clk_per/2) twoDigitCounter_clk_tb = ~twoDigitCounter_clk_tb;
        end
    //////////////////END CLOCK////////////////////
 twoDigitCounter twoDigitCounter(
    .twoDigitCounter_clk(twoDigitCounter_clk_tb),
    .twoDigitCounter_rst(twoDigitCoutner_rst_tb),
    .twoDigitCounter_clk_rst(twoDigitCounter_clk_rst_tb),
    .twoDigitCounter_first_num(twoDigitCounter_first_num_tb),
    .twoDigitCounter_second_num(twoDigitCounter_second_num_tb)
    );
    
    initial begin
   
        twoDigitCoutner_rst_tb=1;
        twoDigitCounter_clk_rst_tb=0;
        #10
        twoDigitCoutner_rst_tb=0;
        twoDigitCounter_clk_rst_tb=0;
        #200
    
    $finish;
    end
endmodule
