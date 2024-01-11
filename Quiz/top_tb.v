`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:Andres Ruiz 
// 
// Create Date: 09/30/2023 02:42:14 PM
// Design Name: Lab 6
// Module Name: top
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
 `define clk_per 0.1
 `define iterations 100_000_00

module top_tb(); 
    reg top_clk_tb;
    reg top_rst_tb;
    reg top_load_tb;
    reg [3:0] top_load_input_RIGHT_tb;
    reg [3:0] top_load_input_LEFT_tb;
    reg top_direction_LEFT_tb;
    reg top_direction_RIGHT_tb;
    reg top_direction_RIGHT_MIDDLE_tb;
    reg top_direction_LEFT_MIDDLE_tb;
    reg [3:0] top_input_MIDDLE_TO_MUX_tb;
    wire [6:0] top_port_ssd_tb;              // Output to SSD
    reg [7:0] top_port_an_tb;  
//    wire [31:0] top_out_tb;  
//    wire  [3:0] top_UDBC_TO_COMP_RIGHT_tb;
//    wire [3:0] top_UDBC_TO_COMP_LEFT_tb;
    /////////////////CLOCK/////////////////////////
    initial
        begin
            top_clk_tb = 1;
        end
    always
        begin
            #(`clk_per/2) top_clk_tb = ~top_clk_tb;
        end
    //////////////////END CLOCK////////////////////

top #(.SSD(2),.clock(4)) top_test(
    .top_clk(top_clk_tb),
    .top_rst(top_rst_tb),
    .top_load(top_load_tb),
    .top_load_input_RIGHT(top_load_input_RIGHT_tb),
    .top_load_input_LEFT(top_load_input_LEFT_tb),
    .top_direction_LEFT(top_direction_LEFT_tb),
    .top_direction_RIGHT(top_direction_RIGHT_tb),
    .top_direction_RIGHT_MIDDLE(top_direction_RIGHT_MIDDLE_tb),
    .top_direction_LEFT_MIDDLE(top_direction_LEFT_MIDDLE_tb),
    .top_input_MIDDLE_TO_MUX(top_input_MIDDLE_TO_MUX_tb),
    .top_port_ssd(top_port_ssd_tb),              // Output to SSD
    .top_port_an()                  // Output to SSD analog selector
//    .top_out(top_out_tb),
//    .top_UDBC_TO_COMP_RIGHT(top_UDBC_TO_COMP_RIGHT_tb),
//    .top_UDBC_TO_COMP_LEFT(top_UDBC_TO_COMP_LEFT_tb)
    );
    
    initial
        begin 
        top_port_an_tb = 0;
top_rst_tb = 0;
top_load_tb = 0;
top_load_input_RIGHT_tb=0;
top_load_input_LEFT_tb=0;
top_direction_LEFT_tb=1;
top_direction_RIGHT_tb=0;
top_direction_RIGHT_MIDDLE_tb=1;
top_direction_LEFT_MIDDLE_tb=0;
top_input_MIDDLE_TO_MUX_tb=0;

            #10000
        $finish;
        end
endmodule    

