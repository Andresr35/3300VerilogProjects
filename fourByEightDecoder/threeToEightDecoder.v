`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/18/2023 09:51:04 AM
// Design Name: 
// Module Name: threeToEightDecoder
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


module threeToEightDecoder(
    input [2:0] A,
    input E,
    output [7:0] Out
    
    );
    wire temp;
    wire [2:0] temp_A;
    wire tempNot;
   
    not(temp,A[2]); // inverse of A2;
    
    and(temp_A[0],E,A[0]);
    and(temp_A[1],E,A[1]);
    and(temp_A[2],E,A[2]);
    and(tempNot,E,temp);

    twoToFourDecoder twoToFourDecoder1(
        .A(temp_A[0]),
        .B(temp_A[1]),
        .E(tempNot),
        .Out(Out[3:0])
    );
    twoToFourDecoder twoToFourDecoder2(
        .A(temp_A[0]),
        .B(temp_A[1]),
        .E(temp_A[2]),
        .Out(Out[7:4])
    );
    
endmodule
