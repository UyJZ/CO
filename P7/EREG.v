`timescale 1ns / 1ps
module EREG(
    input [31:0] GRF_data1,
	 input [31:0] GRF_data2,
	 input [31:0] instr,
	 input [31:0] pc,
	 input clk,
	 input reset,
	 input STALL,
	 input Req,
	 input WE,
	 input [31:0] imm32_in,
	 input D_DelaySlot,
	 output reg E_DelaySlot,
	 input [4:0] D_EXCcode,
	 output reg [4:0] temp_E_EXCcode,
	 output reg [31:0] pc_out,
	 output reg [31:0] imm32_out,
	 output reg [31:0] instr_out,
	 output reg [31:0] data1_out,
	 output reg [31:0] data2_out
	 );
	 always@(posedge clk)begin
	     if(reset || Req || STALL)begin
		      data1_out <= 32'h0000_0000;
				data2_out <= 32'h0000_0000;
				imm32_out <= 32'h0000_0000;
		      pc_out <= Req ? 32'h0000_4180:(STALL?pc:32'h0000_3000);
				instr_out <= 32'h0000_0000;
				temp_E_EXCcode <= 5'b0;
				E_DelaySlot <= STALL?D_DelaySlot:0;
		  end
		  else if(WE) begin
		      instr_out <= instr;
		      data1_out <= GRF_data1;
				data2_out <= GRF_data2;
				imm32_out <= imm32_in;
				pc_out <= pc;
				temp_E_EXCcode <= D_EXCcode;
				E_DelaySlot <= D_DelaySlot;
		  end
	 end


endmodule
