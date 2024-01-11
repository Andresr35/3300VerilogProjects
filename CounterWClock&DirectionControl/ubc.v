`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/23/2023 01:34:45 PM
// Design Name: 
// Module Name: ubc
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


module ubc(
    input ubc_clk,                              // Clock for ubc
    input ubc_rst,                              // Reset for ubc
    input ubc_en,                               // En for ubc
    output [3:0] ubc_q                          // Output for ssd
    );
    
    reg [3:0] ubc_temp;
       
    initial
        begin
            ubc_temp <= 0;
        end
    always@(posedge ubc_clk)
        begin:ubc_OP
              if(ubc_rst) 
                ubc_temp =0;
                
              else
                begin:EN_ACTIVE
                    if(ubc_en) begin
                        if(ubc_temp==9)ubc_temp <=0; // if its equal to 0 
                        else
                        ubc_temp <= ubc_temp+1;
                    end
                      
                        
                end
        end
        assign ubc_q = ubc_temp;
        
endmodule
