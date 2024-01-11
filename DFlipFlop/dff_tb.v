`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Andres Ruiz
// 
// Create Date: 09/25/2023 06:44:17 PM
// Design Name: test bench D Flip Flop
// Module Name: dff_tb
// Project Name: 
// Target Devices: Nexys
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

    `define clock_period 10                 // Creating a variable for our clokc
    
module dff_tb();
    reg dff_port_clk_tb;
    reg dff_port_rst_tb;
    reg dff_port_en_tb;
    reg dff_port_d_tb;
    
    wire dff_oport_q_tb;
    
    initial
        begin:INIT_CLK
            dff_port_clk_tb = 1;            // Start the clock on
        end
    always
        begin:PERIODIC_UPDATE
            #(`clock_period/2)              // Half of clock time
            dff_port_clk_tb = ~dff_port_clk_tb; // Invert Clock
        end    
        
    dff dff_test(
        .dff_port_clk(dff_port_clk_tb),
        .dff_port_rst(dff_port_rst_tb),
        .dff_port_en(dff_port_en_tb),
        .dff_port_d(dff_port_d_tb),
        .dff_oport_q(dff_oport_q_tb)
        );
        
        initial                             // Start testing
            begin:TST1
                dff_port_rst_tb = 1;
                dff_port_en_tb  = 1'bZ;
                dff_port_d_tb   = 1'bZ;
                #(`clock_period)
                dff_port_rst_tb = 0;
                dff_port_en_tb  = 1'b0;
                #(`clock_period)
                dff_port_d_tb   = 1'b1;
                #(`clock_period)
                dff_port_en_tb   = 1'b1;
                #(5 * `clock_period)
                $finish;
            
            end
        
endmodule
