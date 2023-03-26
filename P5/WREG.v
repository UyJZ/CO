`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:17:42 11/06/2022 
// Design Name: 
// Module Name:    WREG 
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
module WREG(
    input clk,
	 input reset,
	 input WE,
    input [31:0] instr_M,
	 input [31:0] M_ALU_out,
	 input [31:0] M_DM_out,
	 input [31:0] M_RT,
	 input [31:0] PC_M,
	 output reg[31:0] instr_W,
	 output reg[31:0] W_ALU_out,
	 output reg[31:0] W_DM_out,
	 output reg[31:0] W_RT,
	 output reg[31:0] PC_W
	 );
	 
	 always@(posedge clk)begin
	     if(reset)begin
		      instr_W <= 32'h0000_0000;
	         W_ALU_out <= 0;
				W_DM_out <= 0;
				W_RT <= 0;
				PC_W <= 32'h0000_3000;
		  end
		  else if(WE)begin
		      instr_W <= instr_M; 
	         W_ALU_out <= M_ALU_out;
				W_DM_out <= M_DM_out;
				W_RT <= M_RT;
				PC_W <= PC_M;
		  end
	 end


endmodule
