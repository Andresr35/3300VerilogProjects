`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/23/2023 08:34:33 AM
// Design Name: 
// Module Name: ssd_manager_tb
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
  `define clk_per 0.01

module ssd_manager_tb();
reg ssd_manager_clk_tb;  
reg [3:0] ssd_manager_port_display1_tb;   
reg [3:0] ssd_manager_port_display2_tb;
wire [6:0] ssd_driver_port_cc_tb;   
wire [7:0] ssd_manager_oport_anode_control_tb;
 
    /////////////////CLOCK/////////////////////////
    initial
        begin
            ssd_manager_clk_tb = 1;
        end
    always
        begin
            #(`clk_per/2) ssd_manager_clk_tb = ~ssd_manager_clk_tb;
        end
    //////////////////END CLOCK////////////////////   
      
ssd_manager ssd_manager_test(
    .ssd_manager_clk(ssd_manager_clk_tb),                // Clock signal
    .ssd_manager_port_display1(ssd_manager_port_display1_tb),   
    .ssd_manager_port_display2(ssd_manager_port_display2_tb),
    .ssd_driver_port_cc(ssd_driver_port_cc_tb),   
    .ssd_manager_oport_anode_control(ssd_manager_oport_anode_control_tb)  
);
    
integer i ,j;
initial begin
#20
    for(i=0;i<10;i=i+1) begin
        ssd_manager_port_display1_tb =i;
        #5_000;
        for(j=0;j<10;j=j+1) begin
            ssd_manager_port_display2_tb=j;
            #(10_000);
        end
    end
    #40
$finish;
end
endmodule
