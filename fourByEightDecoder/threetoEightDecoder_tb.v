`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/18/2023 10:11:49 AM
// Design Name: 
// Module Name: threetoEightDecoder_tb
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


module threetoEightDecoder_tb();
    reg [2:0] Port_A;
    reg Port_E;
    wire [7:0] Port_Out;
    
    threeToEightDecoder threeToEightDecoder_test(
            .A(Port_A),
            .E(Port_E),
            .Out(Port_Out)
    );
    integer i ;
          initial 
            begin:TST
                Port_E=0;
                for(i=0;i<8;i=i+1)
                    begin:FORLOOP
                        #20
                        Port_A=i;
                    end
                Port_E=1;
                for(i=0;i<8;i=i+1)
                    begin:FORLOOPTwo
                        #20
                        Port_A=i;
                    end
                #40
                    $finish;
            end 
endmodule
