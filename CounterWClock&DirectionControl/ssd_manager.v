`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/23/2023 07:37:48 AM
// Design Name: 
// Module Name: ssd_manager
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


module ssd_manager(
  input ssd_manager_clk,                // Clock signal
  input [31:0] ssd_manager_port_input,   
  output [6:0] ssd_driver_port_cc,   
  output [7:0] ssd_manager_oport_anode_control  
);
reg [6:0] ssd_manager_temp_cc;
reg [7:0] ssd_manager_temp_anode;

reg [3:0] ssd_manager_digit_period; // I want each digit to refresh at 1ms which is 1khz
reg [17:0] ssd_manager_digit_counter;
reg [3:0] ssd_manager_temp_num;

initial ssd_manager_digit_counter = 0;
always@(posedge ssd_manager_clk) begin:SSD_REFRESH_PERIOD
    if(ssd_manager_digit_counter == 99_99)begin
        ssd_manager_digit_counter <= 0;
        ssd_manager_digit_period <= ssd_manager_digit_period+1;
    end
    else 
        ssd_manager_digit_counter <= ssd_manager_digit_counter+1;
end

initial ssd_manager_digit_period = 0;
always@(ssd_manager_digit_period)begin
    case(ssd_manager_digit_period)
        0:ssd_manager_temp_anode = 8'b11111110;   
        1:ssd_manager_temp_anode = 8'b11111101; 
        2:ssd_manager_temp_anode = 8'b11111011; 
        3:ssd_manager_temp_anode = 8'b11110111; 
        4:ssd_manager_temp_anode = 8'b11101111; 
        5:ssd_manager_temp_anode = 8'b11011111; 
        6:ssd_manager_temp_anode = 8'b10111111; 
        7:ssd_manager_temp_anode = 8'b01111111; 
    endcase
end

always @*  begin
    case(ssd_manager_digit_period)
        0:
           ssd_manager_temp_num = ssd_manager_port_input[3:0];
        1:
            ssd_manager_temp_num = ssd_manager_port_input[7:4];
        2:
            ssd_manager_temp_num = ssd_manager_port_input[11:8];
        3:
            ssd_manager_temp_num = ssd_manager_port_input[15:12];
        4:
            ssd_manager_temp_num = ssd_manager_port_input[19:16];
        5:
            ssd_manager_temp_num = ssd_manager_port_input[23:20];
        6:
            ssd_manager_temp_num = ssd_manager_port_input[27:24];
        7:
            ssd_manager_temp_num = ssd_manager_port_input[31:28];            
    endcase
    case(ssd_manager_temp_num)
        4'h0: ssd_manager_temp_cc = 7'b1000000; 
        4'h1: ssd_manager_temp_cc = 7'b1111001; 
        4'h2: ssd_manager_temp_cc = 7'b0100100; 
        4'h3: ssd_manager_temp_cc = 7'b0110000; 
        4'h4: ssd_manager_temp_cc = 7'b0011001; 
        4'h5: ssd_manager_temp_cc = 7'b0010010; 
        4'h6: ssd_manager_temp_cc = 7'b0000010; 
        4'h7: ssd_manager_temp_cc = 7'b1111000; 
        4'h8: ssd_manager_temp_cc = 7'b0000000; 
        4'h9: ssd_manager_temp_cc = 7'b0010000; 
        4'hA: ssd_manager_temp_cc = 7'b0001000; 
        4'hB: ssd_manager_temp_cc = 7'b0000011; 
        4'hC: ssd_manager_temp_cc = 7'b1000110; 
        4'hD: ssd_manager_temp_cc = 7'b0100001; 
        4'hE: ssd_manager_temp_cc = 7'b0000110;     
        4'hF: ssd_manager_temp_cc = 7'b0001110;    
        default: ssd_manager_temp_cc = 7'hZZ; 
    endcase
end
assign ssd_driver_port_cc = ssd_manager_temp_cc;
assign ssd_manager_oport_anode_control = ssd_manager_temp_anode;
endmodule
