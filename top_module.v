`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.07.2023 12:48:41
// Design Name: 
// Module Name: top_module
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


module top_module( input wire clk, input wire [7:0]switch, input [3:0]button,
 output wire [3:0] anode, output wire [7:0] cathode
 
    );
    
    wire refreshclock;
    wire [1:0] refreshcounter;
    wire [3:0] one_digit;
    
    clock_divider refresh_generator(.clk(clk), .divider_clk(refreshclock) );
    
    refreshcounter wrapper( .r_clk(refreshclock), .r_counter(refreshcounter) );
    
    anode_control anode_wrappert( .r_counter(refreshcounter), .anode(anode) ); 
    
    BCD_converter bcd_wrapper(
    .digit1(switch[3:0]),
    .digit2(switch[7:4]),
    .digit3(button[3:0]),
    .digit4(button[3:0]),
    .r_counter(refreshcounter),
    .one_digit(one_digit)
    );
    
    cathode_convert cathode_wrapper( .digit(one_digit), .cathode(cathode) );
    
endmodule
