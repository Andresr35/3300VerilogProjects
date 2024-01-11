`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Andres R
// 
// Create Date: 09/30/2023 12:21:23 PM
// Design Name: UCH+UCB Counter with SSD and Clock Divider
// Module Name: top.v
// Project Name: Counter
// Target Devices: Nexys A7
// Tool Versions: 
// Description: FIFO LOAD IN AND LOAD OUT
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top(            // # of bits
    input top_port_clk,                     // System Clock
    input top_port_rst,                     // Reset
    input top_port_w,
    input top_port_r,
    input [3:0] top_input,
    output top_port_ack,
    output top_port_full,
    output top_port_empty,
    output [6:0] top_port_ssd,              // Output to SSD
    output [7:0] top_port_an                // Output to SSD analog selector
);
    
wire top_clk_gen_out;                   // Clock Divider Result   

clock_manager clock_manager_CHIP(
    .clock_manager_clk(top_port_clk),
    .clock_manager_factor(26),
    .clock_manager_rst(0),
    .clock_manager_op_clk(top_clk_gen_out)
);

wire [31:0] top_ssd_inp; 

fifo_generator_0 fifo_test(
    .clk(top_clk_gen_out),
    .srst(top_port_rst),
    .din(top_input),
    .wr_en(top_port_w),
    .rd_en(top_port_r),
    .dout(top_ssd_inp[3:0]),
    .full(top_port_full),
    .wr_ack(top_port_ack),
    .empty(top_port_empty)
);

reg [23:0] written; 
assign top_ssd_inp[31:28] = top_input; 
assign top_ssd_inp[27:4] = written;
integer i;
initial written = 0;

always @(posedge top_clk_gen_out )begin
    if(top_port_rst)begin
        written = 0;
        i=0;
    end else
        if(top_port_w)begin
            if(i==6)i=0;
            written[i*4 +:4] = top_input;
            i=i+1;
        end
end 

ssd_manager ssdCHIP(
    .ssd_manager_clk(top_port_clk),                 
    .ssd_manager_port_input(top_ssd_inp),                      
    .ssd_driver_port_cc(top_port_ssd),              // Output to seven segment
    .ssd_manager_oport_anode_control(top_port_an)   // Output to analog 
);

endmodule
