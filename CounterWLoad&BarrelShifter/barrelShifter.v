`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/03/2023 02:26:18 AM
// Design Name: 
// Module Name: barrelShifter
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


module barrelShifter #(parameter SIZE=4)(
    input [SIZE-1:0] barrelShifter_port_input,
    input barrelShifter_port_sr,
    input [$clog2(SIZE)-1:0] barrelShifter_port_shift,
    input barrelShifter_port_direction,
    output [SIZE-1:0] barrelShifter_port_output
);
wire [SIZE:0] barrelShifter_select [$clog2(SIZE)-1:0]; //[levels][mux]
wire [SIZE-1:0] barrelShifter_mp_temp [$clog2(SIZE):0]; // [levels][mux]
wire [SIZE-1:0] barrelShifter_sr_output [$clog2(SIZE)-1:0]; // [levels][mux]
wire [SIZE-1:0] barrelShifter_direction_output [$clog2(SIZE)-1:0];//[levels][mux]
    
assign barrelShifter_mp_temp[0] = barrelShifter_port_input;// set the first level input to port input

genvar levels,mid_mux,last_mux,start_mux;
generate
    for(levels = 0; levels < $clog2(SIZE); levels = levels+1) begin:LOOPLEVELS
        assign barrelShifter_select[levels][SIZE] = barrelShifter_port_shift[levels]; 
        for(start_mux = 0; start_mux<levels+1;start_mux= start_mux+1) begin:LOOP_FIRST_MUX
            assign barrelShifter_select[levels][start_mux] = 
                        barrelShifter_select[levels][start_mux+1];
            assign barrelShifter_sr_output[levels][start_mux] = 
                        barrelShifter_port_sr?barrelShifter_mp_temp[levels][start_mux+(SIZE-1)-levels%SIZE]:0;
            assign barrelShifter_direction_output[levels][start_mux] = 
                        barrelShifter_port_direction?barrelShifter_sr_output[levels][start_mux]:barrelShifter_mp_temp[levels][((start_mux+1)+levels)%SIZE];
            assign barrelShifter_mp_temp[levels+1][start_mux] = 
                        barrelShifter_select[levels][start_mux]?barrelShifter_direction_output[levels][start_mux]:barrelShifter_mp_temp[levels][start_mux];
        end
                
        for(mid_mux=levels+1; mid_mux<(SIZE-1-levels); mid_mux= mid_mux+1) begin:LOOP_MIDDLE_MUX
            assign barrelShifter_select[levels][mid_mux] = barrelShifter_select[levels][mid_mux+1];
            assign barrelShifter_direction_output[levels][mid_mux] =
                barrelShifter_port_direction?barrelShifter_mp_temp[levels][((mid_mux+(SIZE-1))-levels)%SIZE]:barrelShifter_mp_temp[levels][((mid_mux+1)+levels)%SIZE];
            assign barrelShifter_mp_temp[levels+1][mid_mux] = 
                barrelShifter_select[levels][mid_mux]?barrelShifter_direction_output[levels][mid_mux]:barrelShifter_mp_temp[levels][mid_mux];
        end
                            
        for(last_mux = (SIZE-1-levels);last_mux<SIZE;last_mux = last_mux+1) begin:LOOP_FINAL_MUX   
            assign barrelShifter_select[levels][last_mux] = barrelShifter_select[levels][last_mux+1];
            assign barrelShifter_sr_output[levels][last_mux] =
                barrelShifter_port_sr?barrelShifter_mp_temp[levels][((last_mux+1)+levels)%SIZE]:0;
            assign barrelShifter_direction_output[levels][last_mux]=
                barrelShifter_port_direction?barrelShifter_mp_temp[levels][((last_mux+(SIZE-1))-levels)%SIZE]:barrelShifter_sr_output[levels][last_mux];
            assign barrelShifter_mp_temp[levels+1][last_mux] = 
                barrelShifter_select[levels][last_mux]?barrelShifter_direction_output[levels][last_mux]:barrelShifter_mp_temp[levels][last_mux];              
        end
    end
    assign barrelShifter_port_output = barrelShifter_mp_temp[$clog2(SIZE)];// Output is equal to last mux output
endgenerate
endmodule
