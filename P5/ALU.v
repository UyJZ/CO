`timescale 1ns / 1ps
`include "const.v"
module ALU(
    input [3:0] ALUop,
	 input [31:0] ALU_in1,
	 input [31:0] ALU_in2,
	 output reg [31:0] ALU_out
    );
	 wire [31:0] sra = $signed($signed(ALU_in1) >>> ALU_in2);
	 wire [31:0] lui = {(ALU_in2[15:0]),16'b0};
	 always@(*)begin
	     case(ALUop)
		      `ALU_add: ALU_out <= ALU_in1 + ALU_in2;
				`ALU_sub: ALU_out <= ALU_in1 - ALU_in2;
				`ALU_or:  ALU_out <= ALU_in1 | ALU_in2;
				`ALU_lui: ALU_out <= lui;
				`ALU_and: ALU_out <= ALU_in1 & ALU_in2;
				`ALU_xor: ALU_out <= ALU_in1 ^ ALU_in2;
				`ALU_nor: ALU_out <= ~(ALU_in1 | ALU_in2);
				`ALU_sll: ALU_out <= ALU_in1 >> ALU_in2;
				`ALU_srl: ALU_out <= ALU_in1 << ALU_in2;
				`ALU_sra: ALU_out <= sra;
				default:  ALU_out <= 32'h0000_0000;
		  endcase
	 end


endmodule
