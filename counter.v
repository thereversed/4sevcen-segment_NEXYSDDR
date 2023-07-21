`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.07.2023 11:42:04
// Design Name: 
// Module Name: counter
// Project Name: 

//////////////////////////////////////////////////////////////////////////////////


module refreshcounter(input  r_clk, output reg [1:0] r_counter =0

    );
    
    always@(posedge r_clk)  r_counter <= r_counter +1;
   
endmodule


module anode_control ( input [1:0]r_counter, output reg[3:0] anode=0
);

    always@(r_counter)
    begin
        case(r_counter)
        2'b00 : anode =4'b1110; // righgt most digit
        2'b01 : anode = 4'b1101;
        2'b10 : anode = 4'b1011;
        2'b11: anode= 4'b0111; // left most digit 
        endcase
    end
    
endmodule


// module for BCD converter
module BCD_converter(

    input [3:0] digit1, // right most digit (ones)
    input [3:0] digit2, // tens
    input [3:0] digit3, // hundread
    input [3:0] digit4, // leftmost digit , thousands
    input [1:0] r_counter,
    output reg [3:0]one_digit // choose which diigita is to displayed
    );
    
    always@(r_counter)
        begin
            case(r_counter)
            2'd0 : one_digit  = digit1; // righgt most digit
            2'd1 : one_digit =  digit2;
            2'd2 : one_digit =  digit3;
            2'd3 : one_digit =  digit4; // left most digit 
            endcase
        end   
    
endmodule

// cathode converter module
module cathode_convert(
    input [3:0] digit,
    output reg [7:0] cathode =0
);    
    always@(digit)
    begin
        case (digit)
        4'd0: cathode = 8'b11000000;
        4'd1: cathode = 8'b11111001;
        4'd2: cathode = 8'b10100100;
        4'd3: cathode = 8'b10110000;
        4'd4: cathode = 8'b10011001;
        4'd5: cathode = 8'b10010010;
        4'd6: cathode = 8'b10000010;
        4'd7: cathode = 8'b11111000;
        4'd8: cathode = 8'b10000000;
        4'd9: cathode = 8'b10010000;
        default : cathode = 8'b11000000;        
        endcase
 
    end 
   
endmodule

module clock_divider( input clk, output reg divider_clk =0
);
    integer counter_value=0;
    always@(posedge clk)
    begin
        if(counter_value == 1000)
        counter_value <= 0;
        else
            counter_value <= counter_value+1;
    end
    
    // divide block 
    
    always@(posedge clk)
    begin
        if(counter_value == 1000)
            divider_clk <= ~divider_clk;
        else
            divider_clk <= divider_clk;
    end
endmodule