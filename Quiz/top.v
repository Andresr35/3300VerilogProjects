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
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top #(parameter SSD=200_000, clock=26)(            // # of bits
    input top_clk,
    input top_rst,
    input top_load,
    input [3:0] top_load_input_RIGHT,
    input [3:0] top_load_input_LEFT,
    input top_direction_LEFT,
    input top_direction_RIGHT,
    input top_direction_RIGHT_MIDDLE,
    input top_direction_LEFT_MIDDLE,
    input [3:0] top_input_MIDDLE_TO_MUX,
    output [6:0] top_port_ssd,              // Output to SSD
    output [7:0] top_port_an   
//    output [31:0] top_out, 
//    output  [3:0] top_UDBC_TO_COMP_RIGHT,
//    output [3:0] top_UDBC_TO_COMP_LEFT
);

wire top_clk_gen_out;
wire [2:0] threeBitUC_OUT;

clock_manager clock_manager_CHIP(
    .clock_manager_clk(top_clk),
    .clock_manager_factor(clock),
    .clock_manager_rst(0),
    .clock_manager_op_clk(top_clk_gen_out)
);

threeBitUC threeBitUC_CHIP(
    .uc_clk(top_clk_gen_out),                              
    .uc_out(threeBitUC_OUT)                          
);

wire [3:0] UDBC_TO_BS_R;
wire [3:0] BS_TO_MUX_R;
wire [3:0] UDBC_TO_BS_L;
wire [3:0] BS_TO_MUX_L;

udbManager BS_INPUT_RIGHT(
    .udbManager_clk(top_clk_gen_out),
    .udbManager_rst(top_rst),
    .udbManager_load(top_load),
    .udbManager_load_input(top_load_input_RIGHT),
    .udbManager_direction(top_direction_RIGHT),
    .udbManager_out(UDBC_TO_BS_R)
);

barrelShifter BS_RIGHT(
    .barrelShifter_port_input(UDBC_TO_BS_R),
    .barrelShifter_port_sr(threeBitUC_OUT[2]),
    .barrelShifter_port_shift(threeBitUC_OUT[1:0]),
    .barrelShifter_port_direction(0),
    .barrelShifter_port_output(BS_TO_MUX_R)
);

udbManager BS_INPUT_LEFT(
    .udbManager_clk(top_clk_gen_out),
    .udbManager_rst(top_rst),
    .udbManager_load(top_load),
    .udbManager_load_input(top_load_input_LEFT),
    .udbManager_direction(top_direction_LEFT),
    .udbManager_out(UDBC_TO_BS_L)
);

barrelShifter BS_LEFT(
    .barrelShifter_port_input(UDBC_TO_BS_L),
    .barrelShifter_port_sr(threeBitUC_OUT[2]),
    .barrelShifter_port_shift(threeBitUC_OUT[1:0]),
    .barrelShifter_port_direction(0),
    .barrelShifter_port_output(BS_TO_MUX_L)
);

wire [3:0] MUX_TO_UDBC_R;
wire [3:0] MUX_TO_UDBC_L;

wire [3:0] MUX_TO_UDBC_R_MOD;
wire [3:0] MUX_TO_UDBC_L_MOD;
assign MUX_TO_UDBC_R = top_load_input_RIGHT[3]?BS_TO_MUX_R:top_input_MIDDLE_TO_MUX;
assign MUX_TO_UDBC_L = top_load_input_LEFT[3]?BS_TO_MUX_L:top_input_MIDDLE_TO_MUX;
assign MUX_TO_UDBC_R_MOD = MUX_TO_UDBC_R>9?MUX_TO_UDBC_R+6:MUX_TO_UDBC_R;
assign MUX_TO_UDBC_L_MOD = MUX_TO_UDBC_L>9?MUX_TO_UDBC_L+6:MUX_TO_UDBC_L;
wire [3:0] UDBC_TO_COMP_RIGHT;
wire [3:0] UDBC_TO_COMP_LEFT;

//assign top_UDBC_TO_COMP_RIGHT = UDBC_TO_COMP_RIGHT;
//assign top_UDBC_TO_COMP_LEFT = UDBC_TO_COMP_LEFT;

udbManager MUX_INPUT_RIGHT(
    .udbManager_clk(top_clk_gen_out),
    .udbManager_rst(top_rst),
    .udbManager_load(top_load),
    .udbManager_load_input(MUX_TO_UDBC_R_MOD),
    .udbManager_direction(top_direction_RIGHT_MIDDLE),
    .udbManager_out(UDBC_TO_COMP_RIGHT)
);

udbManager MUX_INPUT_LEFT(
    .udbManager_clk(top_clk_gen_out),
    .udbManager_rst(top_rst),
    .udbManager_load(top_load),
    .udbManager_load_input(MUX_TO_UDBC_L_MOD),
    .udbManager_direction(top_direction_LEFT_MIDDLE),
    .udbManager_out(UDBC_TO_COMP_LEFT)
);

wire [2:0] COMP_TO_UH;

comparator comparatorCHIP(
    .comparator_port_A(UDBC_TO_COMP_LEFT),
    .comparator_port_B(UDBC_TO_COMP_RIGHT),
    .comparator_oport_P(COMP_TO_UH)
);

wire [31:0] UC_TO_SSD;
assign UC_TO_SSD[31:12] = 0;
assign top_out = UC_TO_SSD;

uch uchL(
    .uch_clk(top_clk_gen_out),
    .uch_rst(top_rst),
    .uch_en(COMP_TO_UH[0]),
    .uch_out(UC_TO_SSD[3:0])
);
uch uchM(
    .uch_clk(top_clk_gen_out),
    .uch_rst(top_rst),
    .uch_en(COMP_TO_UH[1]),
    .uch_out(UC_TO_SSD[7:4])
);
uch uchR(
    .uch_clk(top_clk_gen_out),
    .uch_rst(top_rst),
    .uch_en(COMP_TO_UH[2]),
    .uch_out(UC_TO_SSD[11:8])
);

ssd_manager #(.SSD(SSD)) ssdCHIP(
    .ssd_manager_clk(top_clk),                 
    .ssd_manager_port_input(UC_TO_SSD),                      
    .ssd_driver_port_cc(top_port_ssd),              // Output to seven segment
    .ssd_manager_oport_anode_control(top_port_an)   // Output to analog 
);
endmodule
