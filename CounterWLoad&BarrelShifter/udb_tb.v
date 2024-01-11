`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/26/2023 01:38:37 PM
// Design Name: 
// Module Name: udb_tb
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

module udb_tb();

    reg udb_clk_tb;                             // Clock for udb
    reg udb_rst_tb;                             // Reset for udb
    reg [3:0] udb_direction_tb;                       // Up or Down Counter
    reg [15:0] udb_load_input_tb;
    reg udb_load_tb; 
    wire [15:0] udb_q_tb;                        // Output num
    
/////////////////CLOCK/////////////////////////
initial
    udb_clk_tb = 1;
always
    #(`clk_per/2) udb_clk_tb = ~udb_clk_tb;
//////////////////END CLOCK////////////////////   

udb udb_test(
    .udb_clk(udb_clk_tb),                              // Clock for udb
    .udb_rst(udb_rst_tb),                              // Reset for udb
    .udb_load(udb_load_tb),
    .udb_load_input(udb_load_input_tb),
    .udb_direction(udb_direction_tb),                        // Up or Down Counter
    .udb_q(udb_q_tb)                      // Output num
);

integer i;
initial begin
    udb_rst_tb = 0;
    udb_load_input_tb = 15'h0015;
    for(i=0;i<2;i=i+1)begin
        udb_direction_tb = i;
        #(`clk_per*20);
    end
    udb_load_tb = 1;
    #(`clk_per*3);
    udb_load_tb = 0;
    #(`clk_per*3);
$finish;
end

endmodule
