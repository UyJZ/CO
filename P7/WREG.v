`timescale 1ns / 1ps
module WREG(
    input clk,
	 input reset,
	 input Req,
	 input WE,
    input [31:0] instr_M,
	 input [31:0] M_ALU_out,
	 input [31:0] M_DM_out,
	 input [31:0] M_RT,
	 input [31:0] PC_M,
	 input [31:0] M_HILO_out,
	 output reg[31:0] W_HILO_out,
	 output reg[31:0] instr_W,
	 output reg[31:0] W_ALU_out,
	 output reg[31:0] W_DM_out,
	 output reg[31:0] W_RT,
	 output reg[31:0] PC_W,
	 input [31:0] M_CP0_out,
	 output reg [31:0] W_CP0_out
	 );
	 
	 always@(posedge clk)begin
	     W_CP0_out <= M_CP0_out;
		  if(reset || Req)begin
		      instr_W <= 32'h0000_0000;
	         W_ALU_out <= 0;
				W_DM_out <= 0;
				W_RT <= 0;
				PC_W <= Req?32'h0000_4180:32'h0000_3000;
				W_HILO_out <= 32'h0;
		  end
		  else if(WE)begin
		      instr_W <= instr_M; 
	         W_ALU_out <= M_ALU_out;
				W_DM_out <= M_DM_out;
				W_RT <= M_RT;
				PC_W <= PC_M;
				W_HILO_out <= M_HILO_out;
		  end
	 end


endmodule
