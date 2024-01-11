`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/12/2023 01:53:39 AM
// Design Name: 
// Module Name: dhbs_tb
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

module dhbs_tb();
    reg dhbs_clk_tb;                              // Clock for dhbs
    reg dhbs_rst_tb;                              // Reset for dhbs
    reg dhbs_sel_tb;                               // En for dhbs
    wire [3:0] dhbs_q_tb;                          // Output for ssd

    /////////////////CLOCK/////////////////////////
    initial
        begin
            dhbs_clk_tb = 1;
        end
    always
        begin
            #(`clock_period/2) dhbs_clk_tb = ~dhbs_clk_tb;
        end
    //////////////////END CLOCK////////////////////
    
    dhbs dhbsTEST(
        .dhbs_clk(dhbs_clk_tb),                              // Clock for dhbs
        .dhbs_rst(dhbs_rst_tb),                              // Reset for dhbs
        .dhbs_sel(dhbs_sel_tb),                               // En for dhbs
        .dhbs_q(dhbs_q_tb)                          // Output for ssd
    );
        initial
        begin 
            dhbs_rst_tb = 1;                              
            dhbs_sel_tb = 1;
            #(`clock_period)
            dhbs_rst_tb = 0;                              
            #((`clock_period)*(`iterations))
            dhbs_sel_tb = 0;
            #((`clock_period)*(`iterations))
            #60
        $finish;
        end
endmodule
