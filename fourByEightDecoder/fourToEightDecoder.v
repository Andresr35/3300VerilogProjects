`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/18/2023 10:46:05 AM
// Design Name: 
// Module Name: fourToEightDecoder
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


module fourToEightDecoder(
    input [3:0] A,
    output [15:0] Out
    );
    wire temp;
    not(temp,A[3]);// inverse of A3
    threeToEightDecoder threeToEightDecoder1(
             .A(A[2:0]),
             .E(temp),
            .Out(Out[7:0])
    );
    threeToEightDecoder threeToEightDecoder2(
             .A(A[2:0]),
             .E(A[3]),
            .Out(Out[15:8])
    );
endmodule
