`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:07:59 11/05/2022 
// Design Name: 
// Module Name:    MREG 
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
module MREG(
    input clk,
	 input reset,
	 input WE,
	 input [31:0] instr_in,
	 input [31:0] PC_in,
	 input [31:0] ALU_in,
	 input [31:0] rt,
	 input [31:0] HILO_in,
	 output reg [31:0] instr_out,
	 output reg [31:0] PC_out,
	 output reg [31:0] ALU_out,
	 output reg [31:0] rt_out,
	 output reg [31:0] HILO_out 
	 );
	 
	 always@(posedge clk)begin
	     if(reset)begin
		      instr_out <= 32'h0000_0000;
				ALU_out <= 32'h0000_0000;
				rt_out <= 32'h0000_0000;
				PC_out <= 32'h0000_3000;
				HILO_out <= 32'h0;
		  end
		  else if(WE)begin
		      instr_out <= instr_in;
				PC_out <= PC_in;
				rt_out <= rt;
				ALU_out <= ALU_in;
				HILO_out <= HILO_in;
		  end
	 end


endmodule
