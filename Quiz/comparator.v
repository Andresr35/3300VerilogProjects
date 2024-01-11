`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/09/2023 02:23:31 AM
// Design Name: 
// Module Name: comparator
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


module comparator(
    input [3:0] comparator_port_A,
    input [3:0] comparator_port_B,
    output [2:0] comparator_oport_P
    );
    
    assign comparator_oport_P[0] = comparator_port_A < comparator_port_B;
    assign comparator_oport_P[1] = comparator_port_A == comparator_port_B;
    assign comparator_oport_P[2] = comparator_port_A > comparator_port_B;
endmodule

