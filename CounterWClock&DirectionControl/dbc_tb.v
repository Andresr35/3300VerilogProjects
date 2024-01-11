`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/12/2023 01:32:23 AM
// Design Name: 
// Module Name: dbc_tb
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


module dbc_tb();

    reg dbc_clk_tb;                              // Clock for dbc
    reg dbc_rst_tb;                              // Reset for dbc
    reg dbc_en_tb;                               // En for dbc
    wire [3:0] dbc_q_tb;                          // Output for ssd
    
    
    /////////////////CLOCK/////////////////////////
    initial
        begin
            dbc_clk_tb = 1;
        end
    always
        begin
            #(`clock_period/2) dbc_clk_tb = ~dbc_clk_tb;
        end
    //////////////////END CLOCK////////////////////
    
    dbc dbc_TEST(
        .dbc_clk(dbc_clk_tb),                              // Clock for dbc
        .dbc_rst(dbc_rst_tb),                              // Reset for dbc
        .dbc_en(dbc_en_tb),                               // En for dbc
        .dbc_q(dbc_q_tb)                          // Output for ssd
    );
    
    initial
        begin 
            dbc_rst_tb = 1;                              
            dbc_en_tb = 1;
            #(`clock_period)
            dbc_rst_tb = 0;                              
            dbc_en_tb = 1;
            #((`clock_period)*(`iterations))
            
            #60
        $finish;
        end
        
endmodule

