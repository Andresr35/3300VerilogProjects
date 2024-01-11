`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/03/2023 10:40:47 AM
// Design Name: 
// Module Name: clk_gen_tb
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

module clk_gen_tb #(parameter SIZE_TB = 26)
    ();

    reg fsys_tb;
    reg clk_gen_rst_tb;
    reg [$clog2(SIZE_TB)-1:0] clk_gen_s_tb;
    wire clk_gen_out_tb;
    
    /////////////////CLOCK/////////////////////////
    initial
        begin
            fsys_tb = 1;
        end
    always
        begin
            #(`clk_per/2) fsys_tb = ~fsys_tb;
        end
    //////////////////END CLOCK////////////////////    
    
    clk_gen  #(.SIZE(SIZE_TB)) clk_gen_test
    (
        .fsys(fsys_tb),
        .clk_gen_rst(clk_gen_rst_tb),
        .clk_gen_s(clk_gen_s_tb),
        .clk_gen_out(clk_gen_out_tb)
    );

    initial
        begin
            #(`clk_per)
            clk_gen_rst_tb = 1;
            #(`clk_per)
            clk_gen_rst_tb=0;
            clk_gen_s_tb=SIZE_TB-1;
            #(`clk_per*1000000000)
        $finish;
        end
endmodule
