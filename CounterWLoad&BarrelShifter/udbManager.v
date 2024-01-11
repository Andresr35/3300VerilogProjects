`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/26/2023 01:58:47 PM
// Design Name: 
// Module Name: udbManager
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


module udbManager(
    input udbManager_clk,
    input udbManager_rst,
    input udbManager_load,
    input [3:0] udbManager_load_input,
    input udbManager_direction,
    output reg [3:0] udbManager_out
    );
    
initial udbManager_out = 0;
always @(posedge udbManager_clk or posedge udbManager_rst or posedge udbManager_load)begin
    if(udbManager_rst)udbManager_out <= 0;
    else if(udbManager_load) udbManager_out <= udbManager_load_input; 
    else begin: COUNTER
        if(udbManager_direction) begin:UP_COUNTER
            if(udbManager_out == 9) udbManager_out <= 0;
            else udbManager_out <= udbManager_out+1;
        end
        else begin: DOWN_COUNTER
           if(udbManager_out == 0) udbManager_out <= 9;
           else udbManager_out <= udbManager_out-1;
        end
    end
end    
endmodule
