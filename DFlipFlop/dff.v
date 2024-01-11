`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/25/2023 06:40:00 PM
// Design Name: 
// Module Name: dff
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


module dff(
    input dff_port_clk,
    input dff_port_rst,
    input dff_port_en,
    input dff_port_d,
    output dff_oport_q
    );
    reg dff_port_temp;
    
    always@(posedge dff_port_clk)
        begin:DFF_OP
            if(dff_port_rst)dff_port_temp <= 1'b0;
            else
                begin:Processing
                    if(dff_port_en)dff_port_temp <=dff_port_d;
                end
        end
        assign dff_oport_q = dff_port_temp;
endmodule
