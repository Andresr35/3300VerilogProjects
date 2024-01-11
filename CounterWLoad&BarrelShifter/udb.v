`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/26/2023 01:28:39 PM
// Design Name: 
// Module Name: udb
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


`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/27/2023 08:24:29 PM
// Design Name: 
// Module Name: uch
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


module udb(
    input udb_clk,                              // Clock for udb
    input udb_rst,                              // Reset for udb
    input udb_load,
    input [15:0] udb_load_input,
    input [3:0] udb_direction,                  // Up or Down Counter
    output [15:0] udb_q                      // Output num
);
wire [3:0] udb_temp_clk;
assign udb_temp_clk[0] = udb_clk;
assign udb_temp_clk[1] =udb_direction[0]? udb_q[3:0] == 4'b0000 : udb_q[3:0] == 4'b1001;
assign udb_temp_clk[2] =(udb_direction[1]? udb_q[7:4] == 0 : udb_q[7:4] == 9);
assign udb_temp_clk[3] =(udb_direction[2]? udb_q[11:8] == 0 : udb_q[11:8] == 9);
genvar i;
generate
    for(i=0;i<4;i=i+1)begin
    udbManager UDBmanagerCHIP(
        .udbManager_clk(udb_temp_clk[i]),
        .udbManager_rst(udb_rst),
        .udbManager_load(udb_load),
        .udbManager_load_input(udb_load_input[(4*i) +: 4]),
        .udbManager_direction(udb_direction[i]),
        .udbManager_out(udb_q[(4*i) +: 4])
    );  
    end
endgenerate


endmodule
