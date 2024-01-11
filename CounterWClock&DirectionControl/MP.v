`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/18/2023 06:36:54 PM
// Design Name: 
// Module Name: MP
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


module MP(
    input sel,
    input I0,
    input I1,
    output P
    );
    
    assign P =  (I0&(~sel))|(I1&sel);
endmodule
