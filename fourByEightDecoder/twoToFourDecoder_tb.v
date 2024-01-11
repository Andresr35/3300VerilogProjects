`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/18/2023 10:26:00 AM
// Design Name: 
// Module Name: twoToFourDecoder_tb
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


module twoToFourDecoder_tb( );
    reg Port_A;
    reg Port_B;
    reg Port_E;
    wire [3:0] Port_Out;
    
    twoToFourDecoder twoToFourDecoder_test(
            .A(Port_A),
            .B(Port_B),
            .E(Port_E),
            .Out(Port_Out)
    );
    
          initial 
            begin:TST
                    Port_A = 0;
                    Port_B = 0;
                    Port_E=1;
                #20
                    Port_A = 1;
                #20
                    Port_A = 0;
                    Port_B = 1;
                #20
                    Port_A = 1;
                #20
                    Port_A = 1;
                    Port_B = 1;
                #40
                    $finish;
            end 
endmodule
