`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/12/2023 01:17:03 AM
// Design Name: 
// Module Name: dhc
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


module dhc(
    input dhc_clk,                              // Clock for dhc
    input dhc_rst,                              // Reset for dhc
    input dhc_en,                               // En for dhc
    output [3:0] dhc_q                          // Output for ssd
    );
    
    reg [3:0] dhc_temp;
       
    initial
        begin
            dhc_temp = 15;
        end
    always@(posedge dhc_clk)
        begin:dhc_OP
              if(dhc_rst) 
                begin
                    dhc_temp <=15;
                end
              else
                begin:EN_ACTIVE
                    if(dhc_en)
                        dhc_temp <= dhc_temp-1;
                end
        end
        assign dhc_q = dhc_temp;
        
endmodule
