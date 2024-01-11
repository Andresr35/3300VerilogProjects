`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/27/2023 08:24:29 PM
// Design Name: 
// Module Name: uch
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


module uch(
    input uch_clk,                              // Clock for uch
    input uch_rst,                              // Reset for uch
    input uch_en,                               // En for uch
    input uch_sel,                              // select for uch or ucb
    output [3:0] uch_q                          // Output for ssd
    );
    
    reg [3:0] uch_temp;
    wire uch_temp_nine_boolean;
    wire uch_temp_rst;
    wire uch_final_rst;
    
    assign uch_temp_nine_boolean = uch_q[0] & ~uch_q[1] & ~uch_q[2] & uch_q[3]; // whether number 9 has hit or not
    
    MP MP_chip(
    .sel(uch_sel),
    .I0(),
    .I1(uch_temp_nine_boolean),
    .P(uch_temp_rst)
    );
    
    assign uch_final_rst = uch_temp_rst | uch_rst;
    
    initial
        begin
            uch_temp <= 0;
        end
    always@(posedge uch_clk)
        begin:UCH_OP
              if(uch_final_rst) 
                begin
                    uch_temp =0;
                end
              else
                begin:EN_ACTIVE
                    if(uch_en)
                        uch_temp <= uch_temp+1;
                end
        end
        assign uch_q = uch_temp;
        
endmodule
