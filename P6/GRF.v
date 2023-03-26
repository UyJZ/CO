`timescale 1ns / 1ps
`include "const.v"
module GRF(
    input clk,
	 input reset,
    input WE,
	 input [31:0] PC,
	 input [4:0] add1,
	 input [4:0] add2,
	 input [4:0] add_write,
	 input [31:0] WD,
	 output [31:0] GRF_out1,
	 output [31:0] GRF_out2
    );
	 reg [31:0] GRF_reg [31:0];
	 integer i;
	 assign GRF_out1 = (add1 == add_write && add1 != 0 && WE)?WD:GRF_reg[add1];
	 assign GRF_out2 = (add2 == add_write && add2 != 0 && WE)?WD:GRF_reg[add2];
	 initial begin
	     for(i = 0;i < 32;i = i + 1)begin
		      GRF_reg[i] = 32'b0;
		  end
	 end
	 always@(posedge clk)begin
	     if(reset == 1)begin
		      for(i = 0;i < 32;i = i + 1)begin
		      GRF_reg[i] <= 32'b0;
				end
		  end
		  else if(WE && add_write != 5'b0) begin
		     GRF_reg[add_write] <= WD;
		  end
	 end
	 
	 


endmodule
