`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/04/2023 07:07:02 PM
// Design Name: 
// Module Name: barrelShifter_tb
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
 `define clk 5

module barrelShifter_tb #(parameter SIZE_TB = 4) ();

    reg [SIZE_TB-1:0] barrelShifter_port_input_tb;
    reg barrelShifter_port_sr_tb;
    reg [$clog2(SIZE_TB)-1:0] barrelShifter_port_shift_tb;
    reg barrelShifter_port_direction_tb;
    wire [SIZE_TB-1:0] barrelShifter_port_output_tb;

 barrelShifter #(.SIZE(SIZE_TB)) barrelShifter_TB(
    .barrelShifter_port_input(barrelShifter_port_input_tb),
    .barrelShifter_port_sr(barrelShifter_port_sr_tb),
    .barrelShifter_port_shift(barrelShifter_port_shift_tb),
    .barrelShifter_port_direction(barrelShifter_port_direction_tb),
    .barrelShifter_port_output(barrelShifter_port_output_tb)
    );
    
    integer i,k,j,l;
    initial 
        begin:TST
            for(l =0;l<2;l=l+1)begin:LOOPDIRECTION
                barrelShifter_port_direction_tb = l;
                for(k=0;k<SIZE_TB+1;k=k+1) begin:LOOPSHIFTNUMBER // # of bits
                    barrelShifter_port_shift_tb =k;
                    for(j=0;j<2;j=j+1) begin:LOOPSWITCHROTATE
                            barrelShifter_port_sr_tb=j;
                            for(i=0;i<2**SIZE_TB;i=i+1) begin:LOOPINPUTS
                                    barrelShifter_port_input_tb =i;
                                    #(`clk);
                                end                
                        end
                end
            end
            #(`clk*10)
        $finish;
        end
endmodule
