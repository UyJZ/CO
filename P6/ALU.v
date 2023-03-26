`timescale 1ns / 1ps
`include "const.v"
module ALU(
    input [3:0] ALUop,
	 input [31:0] ALU_in1,
	 input [31:0] ALU_in2,
	 input [4:0] shamt,
	 output [31:0] ALU_out
    );
	 wire [31:0] sra = $signed($signed(ALU_in1) >>> shamt);
	 wire [31:0] lui = {(ALU_in2[15:0]),16'b0};
	 assign ALU_out = (ALUop == `ALU_add) ? ALU_in1 + ALU_in2:
	                  (ALUop == `ALU_sub) ? ALU_in1 - ALU_in2:
							(ALUop == `ALU_or) ? ALU_in1 | ALU_in2:
							(ALUop == `ALU_lui) ? lui:
							(ALUop == `ALU_and) ? ALU_in1 & ALU_in2:
							(ALUop == `ALU_xor) ? ALU_in1 ^ ALU_in2:
							(ALUop == `ALU_nor) ? ~(ALU_in1 | ALU_in2):
							(ALUop == `ALU_sll) ? ALU_in1 >> shamt:
							(ALUop == `ALU_srl) ? ALU_in1 << shamt:
							(ALUop == `ALU_sra) ? sra:
							(ALUop == `ALU_slt) ? $signed(ALU_in1) < $signed(ALU_in2):
							(ALUop == `ALU_sltu) ? ALU_in1 < ALU_in2:
							32'h0000_0000;


endmodule
