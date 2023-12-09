`timescale 1ns / 1ps
module MREG(
    input clk,
	 input reset,
	 input Req,
	 input WE,
	 input [31:0] instr_in,
	 input [31:0] PC_in,
	 input [31:0] ALU_in,
	 input [31:0] rt,
	 input [31:0] HILO_in,
	 input E_AdEL,
	 output reg M_AdEL_add,
	 input E_AdES,
	 output reg M_AdES_add,
	 input [4:0] E_EXCcode,
	 output reg [4:0] temp_M_EXCcode,
	 output reg [31:0] instr_out,
	 output reg [31:0] PC_out,
	 output reg [31:0] ALU_out,
	 output reg [31:0] rt_out,
	 output reg [31:0] HILO_out,
	 input E_DelaySlot,
	 output reg M_DelaySlot
	 );
	 
	 always@(posedge clk)begin
	     if(reset || Req)begin
		      instr_out <= 32'h0000_0000;
				ALU_out <= 32'h0000_0000;
				rt_out <= 32'h0000_0000;
				PC_out <= Req?32'h0000_4180:32'h0000_3000;
				HILO_out <= 32'h0;
				temp_M_EXCcode <= 0;
				M_AdES_add <= 0;
				M_AdEL_add <= 0;
				M_DelaySlot <= 0;
		  end
		  else if(WE)begin
		      instr_out <= instr_in;
				PC_out <= PC_in;
				rt_out <= rt;
				ALU_out <= ALU_in;
				HILO_out <= HILO_in;
				temp_M_EXCcode <= E_EXCcode;
				M_AdES_add <= E_AdES;
				M_AdEL_add <= E_AdEL;
				M_DelaySlot <= E_DelaySlot;
		  end
	 end


endmodule
