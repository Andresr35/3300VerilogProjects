`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/12/2023 01:19:54 AM
// Design Name: 
// Module Name: dhc_tb
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


module dhc_tb();

    reg dhc_clk_tb;                              // Clock for dhc
    reg dhc_rst_tb;                              // Reset for dhc
    reg dhc_en_tb;                               // En for dhc
    wire [3:0] dhc_q_tb;                          // Output for ssd
    
    
    /////////////////CLOCK/////////////////////////
    initial
        begin
            dhc_clk_tb = 1;
        end
    always
        begin
            #(`clock_period/2) dhc_clk_tb = ~dhc_clk_tb;
        end
    //////////////////END CLOCK////////////////////
    
    dhc dhc_TEST(
        .dhc_clk(dhc_clk_tb),                              // Clock for dhc
        .dhc_rst(dhc_rst_tb),                              // Reset for dhc
        .dhc_en(dhc_en_tb),                               // En for dhc
        .dhc_q(dhc_q_tb)                          // Output for ssd
    );
    
    initial
        begin 
            dhc_rst_tb = 1;                              
            dhc_en_tb = 1;
            #(`clock_period)
            dhc_rst_tb = 0;                              
            dhc_en_tb = 1;
            #((`clock_period)*(`iterations))
            
            #60
        $finish;
        end
        
endmodule
