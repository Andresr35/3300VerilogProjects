`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/12/2023 01:29:37 AM
// Design Name: 
// Module Name: dbc
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


module dbc(
    input dbc_clk,                              // Clock for dbc
    input dbc_rst,                              // Reset for dbc
    input dbc_en,                               // En for dbc
    output [3:0] dbc_q                          // Output for ssd
    );
    
    reg [3:0] dbc_temp;
       
    initial
        begin
            dbc_temp = 9;
        end
    always@(posedge dbc_clk)
        begin:dbc_OP
              if(dbc_rst) 
                begin
                    dbc_temp <=9;
                end
              else
                begin:EN_ACTIVE
                    if(dbc_en) begin
                        if(dbc_temp==0)dbc_temp <=9; // if its equal to 0 
                        else
                        dbc_temp <= dbc_temp-1;
                    end
                      
                        
                end
        end
        assign dbc_q = dbc_temp;
        
endmodule
