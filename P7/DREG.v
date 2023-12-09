`timescale 1ns / 1ps
`include "const.v"
module DREG(
    input clk,
	 input reset,
	 input Req,
	 input [31:0] pc,
	 input [31:0] instr,
	 input WE,
	 input F_DelaySlot,
	 output reg D_DelaySlot,
	 input [4:0] F_EXCcode,
	 output reg [4:0] temp_D_EXCcode,
	 output reg [31:0] pc_out,
	 output reg [31:0] instr_out
	 );
	 initial begin
	     pc_out <= 32'h0000_3000;
		  instr_out <= 32'h0000_0000;
		  D_DelaySlot <= 0;
		  temp_D_EXCcode <= 0;
	 end
	 always@(posedge clk)begin
	     if(reset || Req )begin
		      pc_out <= Req ? 32'h0000_4180:32'h0000_3000;
				instr_out <= 32'h0000_0000;
				D_DelaySlot <= 0;
			   temp_D_EXCcode <= 0;
		  end
		  else if(WE) begin
		      pc_out <= pc;
				D_DelaySlot <= F_DelaySlot;
			   temp_D_EXCcode <= F_EXCcode;
				instr_out <= instr;
		  end
	 end


endmodule
