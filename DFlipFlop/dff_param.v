`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/25/2023 07:33:37 PM
// Design Name: 
// Module Name: dff_param
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


module dff_param #(parameter SIZE = 512)
(
    input dff_param_port_clk,
    input dff_param_port_rst,
    input dff_param_port_en,
    input dff_param_port_sp,
    input dff_param_port_si,
    input [SIZE-1:0] dff_param_port_pi,
    output [SIZE-1:0] dff_param_port_p
    );
    wire [SIZE:0] dff_param_port_temp;
    wire [SIZE:0] dff_param_port_ptmp;
    assign dff_param_port_temp[0] = dff_param_port_si;
    genvar i;
    generate
    for(i = 0; i < SIZE; i = i+1)
        begin
            assign dff_param_port_ptmp[i] = dff_param_port_sp?dff_param_port_temp[i] : dff_param_port_pi[i];
            dff CHP(
                .dff_port_clk(dff_param_port_clk),
                .dff_port_rst(dff_param_port_rst),
                .dff_port_en(dff_param_port_en),
                .dff_port_d(dff_param_port_temp[i]),
                .dff_oport_q(dff_param_port_temp[i+1])
                );
            assign dff_param_port_p[i] = dff_param_port_temp[i+1];
        end
    endgenerate 
endmodule

