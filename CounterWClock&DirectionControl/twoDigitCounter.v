`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/24/2023 06:52:32 PM
// Design Name: 
// Module Name: twoDigitCounter
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


module twoDigitCounter(
    input twoDigitCounter_clk,
    input twoDigitCounter_rst,
    input twoDigitCounter_clk_rst,
    output [3:0] twoDigitCounter_first_num,
    output  [3:0] twoDigitCounter_second_num
    );
    
reg twoDigitCounter_second_clk;
    
uch uch_FIRST_CHIP(
    .uch_clk(twoDigitCounter_clk),              // Clock for uch
    .uch_rst(twoDigitCounter_rst),                 // Reset for uch
    .uch_sel(1),                            // select for uch or ucb
    .uch_q(twoDigitCounter_first_num)              // Output for ssd
);

//////////Clock for second digit///////////
initial begin
    twoDigitCounter_second_clk = 0;
end
always@ (twoDigitCounter_first_num) begin
    if(twoDigitCounter_clk_rst)twoDigitCounter_second_clk=0;
    if(twoDigitCounter_first_num == 0)
        twoDigitCounter_second_clk = 1;
    else twoDigitCounter_second_clk=0;
end
///////////////////////////////////////////

uch uch_Second_CHIP(
    .uch_clk(twoDigitCounter_second_clk),              // Clock for uch
    .uch_rst(twoDigitCounter_rst),                 // Reset for uch
    .uch_sel(1),                            // select for uch or ucb
    .uch_q(twoDigitCounter_second_num)              // Output for ssd
);
endmodule
