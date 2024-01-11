`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/27/2023 04:04:38 PM
// Design Name: 
// Module Name: barrelShifterManager_tb
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

module barrelShifterManager_tb();
reg udbManager_clk_tb;
reg udbManager_rst_tb;
reg udbManager_direction_tb;
wire [31:0] udbManager_temp_tb;
wire [31:0] udbManager_out;

/////////////////CLOCK/////////////////////////
initial
    udbManager_clk_tb = 1;
always
    #(`clk_per/2) udbManager_clk_tb = ~udbManager_clk_tb;
//////////////////END CLOCK////////////////////   

 udbManager udbManagerCHIP(
    .udbManager_clk(udbManager_clk_tb),
    .udbManager_rst(udbManager_rst_tb),
    .udbManager_direction(udbManager_direction_tb),
    .udbManager_out(udbManager_temp_tb)
);

barrelShifterManager barrelShifterManager(
    .barrelShifterManager_port_input(udbManager_temp_tb),
    .barrelShifterManager_port_sr(0),
    .barrelShifterManager_port_shift(0),
    .barrelShifterManager_direction(0),
    .barrelShifterManager_output(udbManager_out)
    );
    
    initial begin
    udbManager_rst_tb = 0;
    udbManager_direction_tb = 0;
    #100_000
    $finish;
    end
endmodule
