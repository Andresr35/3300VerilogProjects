`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/26/2023 02:13:08 PM
// Design Name: 
// Module Name: udbManager_tb
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

module udbManager_tb();
reg udbManager_clk_tb;
reg udbManager_rst_tb;
reg udbManager_direction_tb;
wire [3:0] udbManager_out_tb;
reg udbManager_load_tb;
reg [3:0] udbManager_load_input_tb;

/////////////////CLOCK/////////////////////////
initial
    udbManager_clk_tb = 1;
always
    #(`clk_per/2) udbManager_clk_tb = ~udbManager_clk_tb;
//////////////////END CLOCK////////////////////   

 udbManager udbManagerCHIP(
    .udbManager_clk(udbManager_clk_tb),
    .udbManager_rst(udbManager_rst_tb),
    .udbManager_load(udbManager_load_tb),
    .udbManager_load_input(udbManager_load_input_tb),
    .udbManager_direction(udbManager_direction_tb),
    .udbManager_out(udbManager_out_tb)
);

initial begin
    udbManager_load_input_tb = 5;
    udbManager_rst_tb=0;
    udbManager_direction_tb=0;
    #(`clk_per*12)
    udbManager_direction_tb=1;
    #(`clk_per*12)
    udbManager_load_tb =1 ;
    #(`clk_per*2)
    udbManager_load_tb=0;
    #(`clk_per*5)
$finish;
end
endmodule
