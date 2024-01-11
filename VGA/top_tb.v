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

 `define clk_per 10
 `define iterations 100_000_00

module top_tb();
    reg clk_100MHz;       // from Basys 3
    reg reset;            // btnC on Basys 3
    wire hsync;           // to VGA connector
    wire vsync;           // to VGA connector
    wire [11:0] rgb;                // Output to SSD analog selector
    wire video_on;
    wire p_tick;
    wire [9:0] x;
    wire [9:0] y;
    /////////////////CLOCK/////////////////////////
    initial
        begin
            clk_100MHz = 1;
        end
    always
        begin
            #(`clk_per/2) clk_100MHz = ~clk_100MHz;
        end
    //////////////////END CLOCK////////////////////

    top top_test(
    .clk_100MHz(clk_100MHz),       // from Basys 3
    .reset(reset),            // btnC on Basys 3
    //.hsync(hsync),           // to VGA connector
    //.vsync(vsync),           // to VGA connector
    .rgb(rgb)            // Output to SSD analog selector
    );
     vga_controller VGA_CHP(
    .clk_100MHz(clk_100MHz),   // from Basys 3
    .reset(reset),        // system reset
    .video_on(video_on),    // ON while pixel counts for x and y and within display area
   .hsync(hsync),        // horizontal sync
   .vsync(vsync),       // vertical sync
    .p_tick(p_tick),      // the 25MHz pixel/second rate signal, pixel tick
    .x(x),     // pixel count/position of pixel x, max 0-799
    .y(y)      // pixel count/position of pixel y, max 0-524
    );
    initial
        begin 
            reset = 1;
            #(`clk_per*100)
            reset = 0;
            #(`clk_per*100000)
        $finish;
        end
endmodule    

