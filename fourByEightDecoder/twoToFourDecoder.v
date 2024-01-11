`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/18/2023 10:24:37 AM
// Design Name: 
// Module Name: twoToFourDecoder
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


module twoToFourDecoder(
    input A,
    input B,
    input E,
    output [3:0] Out
    );
    wire [1:0] temp;
    not(temp[0],A); // inverse of A
    not(temp[1],B); // inverse of B
    and(Out[0],temp[0],temp[1],E);
    and(Out[1],A,temp[1],E);
    and(Out[2],temp[0],B,E);
    and(Out[3],A,B,E);
endmodule
