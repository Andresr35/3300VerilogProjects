`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/25/2023 07:47:38 PM
// Design Name: 
// Module Name: dff_param_tb
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
`define clock_period 10
`define step 100
`define iteration 1000

module dff_param_tb#(parameter SIZE_TB = 16)
(
    );
    reg dff_param_port_clk_tb;
    reg dff_param_port_rst_tb;
    reg dff_param_port_en_tb;
    reg dff_param_port_si_tb;
    wire [SIZE_TB-1:0] dff_param_port_p_tb;
    
    initial
        begin
            dff_param_port_clk_tb = 1;
        end
    always
        begin
            #(`clock_period/2) dff_param_port_clk_tb = ~dff_param_port_clk_tb;
        end
dff_param #(.SIZE(SIZE_TB)) CHPTST
(
    .dff_param_port_clk(dff_param_port_clk_tb),
    .dff_param_port_rst(dff_param_port_rst_tb),
    .dff_param_port_en(dff_param_port_en_tb),
    .dff_param_port_si(dff_param_port_si_tb),
    .dff_param_port_p(dff_param_port_p_tb)
    );
    integer i;
    initial
        begin
        dff_param_port_rst_tb = 1;
        dff_param_port_en_tb = 1'bZ;
        dff_param_port_si_tb = 1'bZ;
        #((`step/10)*(`clock_period))
        dff_param_port_rst_tb = 0;
        dff_param_port_en_tb = 1'b1;
        dff_param_port_si_tb = 1'b0;
        #((`step/5)*(`clock_period))
        for (i = 0; i < `iteration; i = i + 1)
            begin
            #(2 * (`clock_period))
            dff_param_port_si_tb = i;
            end
        #((`step/5) * (`clock_period))
        dff_param_port_en_tb = 1'b0;
        #(`step * `clock_period)
        $finish;
        end 
endmodule
