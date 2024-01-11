`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/09/2023 02:26:30 AM
// Design Name: 
// Module Name: threeBitUC
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


module threeBitUC(
    input uc_clk,
    output reg [2:0] uc_out
    );
    
 initial
    uc_out = 0;
always@(posedge uc_clk) begin:UCH_OP
    uc_out <= uc_out+1;
end
endmodule
