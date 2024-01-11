`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/09/2023 04:15:06 AM
// Design Name: 
// Module Name: comparator_tb
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


module comparator_tb();
    reg [3:0] comparator_port_A_tb;
    reg [3:0] comparator_port_B_tb;
    wire [2:0] comparator_oport_P_tb;
    
comparator comparatorTST(
    .comparator_port_A(comparator_port_A_tb),
    .comparator_port_B(comparator_port_B_tb),
    .comparator_oport_P(comparator_oport_P_tb)
);
integer i,j;
initial begin
    for(i=0;i<10;i=i+1)begin
    #10;
        comparator_port_A_tb = i;
        for(j=0;j<10;j=j+1)begin
            #10;
            comparator_port_B_tb = j;
        end
    end
$finish;
end
endmodule
