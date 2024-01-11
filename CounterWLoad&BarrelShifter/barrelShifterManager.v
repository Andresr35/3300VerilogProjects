`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/25/2023 08:23:58 PM
// Design Name: 
// Module Name: barrelShifterManager
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


module barrelShifterManager(
    input [31:0] barrelShifterManager_port_input,
    input barrelShifterManager_port_sr,
    input [1:0] barrelShifterManager_port_shift,
    input barrelShifterManager_direction,
    output [31:0] barrelShifterManager_output
    );
 
genvar i;
generate
    for(i=0;i<8;i=i+1)begin
        barrelShifter #(.SIZE(4)) barrelShifterCHIP(
            .barrelShifter_port_input(barrelShifterManager_port_input[i*4 +: 4]),
            .barrelShifter_port_sr(barrelShifterManager_port_sr),
            .barrelShifter_port_shift(barrelShifterManager_port_shift),
            .barrelShifter_port_direction(barrelShifterManager_direction),
            .barrelShifter_port_output(barrelShifterManager_output[i*4 +: 4])
    );
    end
endgenerate
endmodule
