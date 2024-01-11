`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/12/2023 01:40:09 AM
// Design Name: 
// Module Name: MPnx1
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


module MPnx1 #(parameter SIZE=4)
(
    input [SIZE-1:0] MPnx1_i0,
    input [SIZE-1:0] MPnx1_i1,
    input MPnx1_sel,
    output [SIZE-1:0] MPnx1_p
    );
    
genvar i;
generate 
    for (i = 0; i <SIZE; i = i+1)
        begin 
            MP CELL
             (
                    .sel(MPnx1_sel),
                    .I0(MPnx1_i0[i]),
                    .I1(MPnx1_i1[i]),
                    .P(MPnx1_p[i])
                 );
         end 
endgenerate
endmodule
