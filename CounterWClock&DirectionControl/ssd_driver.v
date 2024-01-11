`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/20/2023 08:14:39 PM
// Design Name: 
// Module Name: ssd_driver
// Project Name: LAB 2 
// Target Devices: 
// Tool Versions: 
// Description: Number driver thingy
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ssd_driver(
        input [3:0] ssd_driver_port_inp,    // Input in binary
        input ssd_driver_port_idp,          // Input for decimal point
 //       output [3:0] ssd_driver_port_led,   // Output to LED in binary
        output [6:0] ssd_driver_port_cc,    // Output to seven segment
        output ssd_driver_port_odp,         // Output to decimal point
        output [7:0] ssd_driver_port_an    // Output to analog 
//        output ssd_driver_port_odp_led       // Output to decimal point LED
    );
    assign ssd_driver_port_odp = ~ssd_driver_port_idp;
   // assign ssd_driver_port_odp_led = ssd_driver_port_idp;
    assign ssd_driver_port_an = 8'b11111110;
  //  assign ssd_driver_port_led = ssd_driver_port_inp;
    
    reg [6:0] ssd_driver_temp_cc;
    wire [3:0] ssd_driver_digit;
    assign ssd_driver_digit = ssd_driver_port_inp;
    
    always@(ssd_driver_digit)
        begin:SEG_ENC
            case(ssd_driver_digit)
            // cg cf ce cd cc cb ca 
            4'h0: ssd_driver_temp_cc = 7'b1000000; //64
            4'h1: ssd_driver_temp_cc = 7'b1111001; //121
            4'h2: ssd_driver_temp_cc = 7'b0100100; //36
            4'h3: ssd_driver_temp_cc = 7'b0110000; //48
            4'h4: ssd_driver_temp_cc = 7'b0011001; //25
            4'h5: ssd_driver_temp_cc = 7'b0010010; //18
            4'h6: ssd_driver_temp_cc = 7'b0000010; 
            4'h7: ssd_driver_temp_cc = 7'b1111000; 
            4'h8: ssd_driver_temp_cc = 7'b0000000; 
            4'h9: ssd_driver_temp_cc = 7'b0010000; 
            4'hA: ssd_driver_temp_cc = 7'b0001000; 
            4'hB: ssd_driver_temp_cc = 7'b0000011; 
            4'hC: ssd_driver_temp_cc = 7'b1000110; 
            4'hD: ssd_driver_temp_cc = 7'b0100001; 
            4'hE: ssd_driver_temp_cc = 7'b0000110; 
            4'hF: ssd_driver_temp_cc = 7'b0001110;    
            default: ssd_driver_temp_cc = 7'hZZ; 
            endcase
        end
    assign ssd_driver_port_cc = ssd_driver_temp_cc;
endmodule
