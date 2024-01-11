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
 `define clk_per 10
 `define iterations 40

module top_tb();
    reg top_clk_tb;
    reg top_rst_tb;
    reg top_en_tb;
    reg top_sel_tb;
//    reg top_port_sr_tb;                    
//    reg [1:0] top_port_shift_tb;
    reg [4:0] top_port_clk_factor_tb;
//    reg top_port_direction_tb;
    wire [6:0] top_ssd_tb;
    wire top_odp_tb;
    wire [7:0] top_an_tb;
    
    /////////////////CLOCK/////////////////////////
    initial
        begin
            top_clk_tb = 1;
        end
    always
        begin
            #(`clk_per/2) top_clk_tb = ~top_clk_tb;
        end
    //////////////////END CLOCK////////////////////

    top #(.SIZE(4)) top_test(
        .top_port_clk(top_clk_tb),
        .top_port_rst(top_rst_tb),
        .top_port_en(top_en_tb),
        .top_port_sel(top_sel_tb),
        .top_port_idp(0),
//        .top_port_sr(top_port_sr_tb),
        .top_port_clk_factor(top_port_clk_factor_tb),
//        .top_port_shift(top_port_shift_tb),
//        .top_port_direction(top_port_direction_tb),
        .top_port_ssd(top_ssd_tb),
        .top_port_odp(top_odp_tb),
        .top_port_an(top_an_tb)
    );
    
    initial
        begin 
            top_rst_tb = 1;                              
            top_en_tb = 1;
            top_sel_tb = 0;
//            top_port_sr_tb = 0;
//            top_port_shift_tb = 2;
            top_port_clk_factor_tb=1;
//            top_port_direction_tb=0;
            #(`clk_per)
            top_rst_tb = 0;                              
            top_en_tb = 1;
            #((`clk_per)*(`iterations))
            top_sel_tb = 1;
            #((`clk_per)*(`iterations))
            #60
        $finish;
        end
endmodule    

