`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/23/2023 01:33:29 PM
// Design Name: 
// Module Name: uhc
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


module uhc(
    input uhc_clk,                              // Clock for uhc
    input uhc_rst,                              // Reset for uhc
    input uhc_en,                               // En for uhc
    output [3:0] uhc_q                          // Output for ssd
    );
    
    reg [3:0] uhc_temp;
       
    initial
        begin
            uhc_temp <= 0;
        end
    always@(posedge uhc_clk)
        begin:uhc_OP
              if(uhc_rst) 
                uhc_temp = 0;
                
              else
                begin:EN_ACTIVE
                    if(uhc_en)
                        uhc_temp <= uhc_temp+1;
                end
        end
        assign uhc_q = uhc_temp;
        
endmodule
