`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/22/2023 06:47:16 PM
// Design Name: Seven Segment Display
// Module Name: ssd_driver_tb
// Project Name: Lab 2
// Target Devices: 
// Tool Versions: 
// Description: Seven Segment Display
// Description: Seven Segment Display
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ssd_driver_tb(
    );
        reg [3:0] ssd_driver_port_inp_tb;
        reg ssd_driver_port_idp_tb;
//        wire [3:0] ssd_driver_port_led_tb;
        wire [6:0] ssd_driver_port_cc_tb;
//        wire ssd_driver_port_odp_tb;
        wire ssd_driver_port_an_tb;
        
        ssd_driver ssd_driver_test(
        .ssd_driver_port_inp(ssd_driver_port_inp_tb),
        .ssd_driver_port_idp(ssd_driver_port_idp_tb),
//        .ssd_driver_port_led(ssd_driver_port_led_tb),
        .ssd_driver_port_cc(ssd_driver_port_cc_tb),
//        .ssd_driver_port_odp(ssd_driver_port_odp_tb),
        .ssd_driver_port_an(ssd_driver_port_an_tb)
        );
        integer i,j;
        initial begin
            #20
            for(j=0;j<2;j=j+1)
                begin
                #20
                ssd_driver_port_idp_tb=j;
                for(i=0;i<16;i=i+1)
                    begin:LOOP_INPUTS
                        #20
                        ssd_driver_port_inp_tb = i;
                    end
                end
            
        $finish;
        end
        
endmodule
