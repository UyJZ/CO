`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:31:01 10/26/2022 
// Design Name: 
// Module Name:    MUX 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module WRsel(
    input [4:0] in_1,
	 input [4:0] in_2,
	 input [1:0] sel,
	 output reg [4:0] out
    );
	 always@(*) begin
	     case(sel)
		      2'b00:begin
				    out <= in_1;
				end
				2'b01:begin
				    out <= in_2;
				end
				2'b10:begin
				    out <= 5'b0000;
				end
		  endcase
	 end


endmodule


module WDsel(
    input [1:0] sel,
	 input [31:0] ALUout,
	 input [31:0] DMout,
	 input [31:0] pc_4,
	 output reg [31:0] out
	 );
	 always@(*)begin
	     case(sel)
		      2'b00:out <= ALUout;
				2'b01:out <= DMout;
				2'b10:out <= pc_4;
		  endcase
	 end


endmodule


module Bsel(
    input sel,
	 input [31:0] in1,
	 input [31:0] in2,
	 output [31:0] out
	 );
	 assign out = (sel == 0)?in1:in2;
	 
endmodule

