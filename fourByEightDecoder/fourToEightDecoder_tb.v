`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/18/2023 11:08:30 AM
// Design Name: 
// Module Name: fourToEightDecoder_tb
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


module fourToEightDecoder_tb();
    reg [3:0] Port_A;
    wire [15:0] Port_Out;
    
    fourToEightDecoder fourToEightDecodertest(
        .A(Port_A),
        .Out(Port_Out)
    );

    integer i ;
          initial 
            begin:TST;
                for(i=0;i<15;i=i+1)
                    begin:FORLOOP
                        #20
                        Port_A=i;
                    end
                #40
                    $finish;
            end 
endmodule
