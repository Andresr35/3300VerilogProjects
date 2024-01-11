`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/02/2023 08:20:23 PM
// Design Name: 
// Module Name: clk_gen
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


module clk_gen #(parameter SIZE = 64)
(
    input clk_gen_fsys,
    input clk_gen_rst,
    input [4:0] clk_gen_factor,
    output clk_gen_out
    );
    
    reg [SIZE-1:0] clk_gen_temp;    
    
    initial
        begin
            clk_gen_temp = 0;
        end
    always@(posedge clk_gen_fsys)
        begin:CLOCKGENERATOR
                    clk_gen_temp <= clk_gen_temp +1;
        end
    assign clk_gen_out = clk_gen_temp[clk_gen_factor-1];
   
endmodule
