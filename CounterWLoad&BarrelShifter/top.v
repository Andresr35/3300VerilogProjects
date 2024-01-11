`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Andres R
// 
// Create Date: 09/30/2023 12:21:23 PM
// Design Name: 
// Module Name: top.v
// Project Name: Counter
// Target Devices: Nexys A7
// Tool Versions: 
// Description: Counter with input load and barrel shifter
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top #(parameter CLK=26)(            // # of bits
    input top_port_clk,                     // System Clock
    input top_port_rst,                     // Reset
    input top_clk_rst,
    input top_load,
    input [15:0] top_input,
    output [6:0] top_port_ssd,              // Output to SSD
    output [7:0] top_port_an                // Output to SSD analog selector
);
    
wire[15:0] top_udb_out;
wire [15:0] top_temp_shifted_num;         // temp variable that has been through barrel shifter
wire [31:0] top_total_out;
wire top_clk_gen_out;                   // Clock Divider Result   
wire [3:0] top_barrel_counter;   

assign top_total_out[15:0] = top_temp_shifted_num;

clock_manager clock_manager_CHIP(
    .clock_manager_clk(top_port_clk),
    .clock_manager_factor(CLK),
    .clock_manager_rst(top_clk_rst),
    .clock_manager_op_clk(top_clk_gen_out)
);
    wire [3:0] top_dir;
    assign top_dir[0] = top_input[3];
    assign top_dir[1] = top_input[7];
    assign top_dir[2] = top_input[11];
    assign top_dir[3] = top_input[15];
    
udb udbCHIP(
    .udb_clk(top_clk_gen_out),                              // Clock for udb
    .udb_rst(top_port_rst),                              // Reset for udb
    .udb_load(top_load),
    .udb_load_input(top_input),
    .udb_direction(top_dir),                  // Up or Down Counter
    .udb_q(top_udb_out)
);

assign top_total_out[31:16] = top_udb_out;

udbManager barrelShifterCounter(
    .udbManager_clk(top_clk_gen_out),
    .udbManager_rst(top_port_rst),
    .udbManager_load(0),
    .udbManager_load_input(0),
    .udbManager_direction(1),
    .udbManager_out(top_barrel_counter)
);
    
barrelShifterManager barrelShifterManagerCHIP(
    .barrelShifterManager_port_input(top_udb_out),
    .barrelShifterManager_port_sr(top_barrel_counter[2]),
    .barrelShifterManager_port_shift(top_barrel_counter[1:0]),
    .barrelShifterManager_direction(top_barrel_counter[1]),
    .barrelShifterManager_output(top_temp_shifted_num)
);
    
ssd_manager ssdCHIP(
    .ssd_manager_clk(top_port_clk),                 
    .ssd_manager_port_input(top_total_out),                      
    .ssd_driver_port_cc(top_port_ssd),              // Output to seven segment
    .ssd_manager_oport_anode_control(top_port_an)   // Output to analog 
);

endmodule
