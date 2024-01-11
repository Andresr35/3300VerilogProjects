`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/10/2023 02:04:15 AM
// Design Name: 
// Module Name: clock_manager_tb
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
 `define clk_per 2

module clock_manager_tb();
    reg clk_gen_fsys_tb;
    reg clk_gen_rst_tb;
    reg [4:0] clk_gen_factor_tb;
    wire clk_gen_out_tb;
    
    /////////////////CLOCK/////////////////////////
    initial
        begin
            clk_gen_fsys_tb = 1;
        end
    always
        begin
            #(`clk_per/2) clk_gen_fsys_tb = ~clk_gen_fsys_tb;
        end
    //////////////////END CLOCK////////////////////
    
    clk_gen #(.SIZE(64)) clk_gen_test
    (
    .clk_gen_fsys(clk_gen_fsys_tb),
    .clk_gen_rst(clk_gen_rst_tb),
    .clk_gen_factor(clk_gen_factor_tb),
    .clk_gen_out(clk_gen_out_tb)
    );
    
    integer i;
    initial
        begin
            clk_gen_rst_tb = 0;
            #(`clk_per)
            for(i=0;i<16;i=i+1)
                begin 
                    #(`clk_per*(2**i))
                    clk_gen_factor_tb = i;
                end
        $finish;
        end
endmodule
