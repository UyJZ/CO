`timescale 1ns / 1ps
`include "const.v"
module DREG(
    input clk,
	 input reset,
	 input [31:0] pc,
	 input [31:0] instr,
	 input WE,
	 output reg [31:0] pc_out,
	 output reg [31:0] instr_out
	 );
	 initial begin
	     pc_out <= 32'h0000_3000;
		  instr_out <= 32'h0000_0000;
	 end
	 always@(posedge clk)begin
	     if(reset)begin
		      pc_out <= 32'h0000_3000;
				instr_out <= 32'h0000_0000;
		  end
		  else if(WE) begin
		      pc_out <= pc;
				instr_out <= instr;
		  end
	 end


endmodule
