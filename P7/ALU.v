`timescale 1ns / 1ps
`include "const.v"
module ALU(
    input calc,
	 input ov,
	 input load,
	 input store,
	 input [3:0] ALUop,
	 input [31:0] ALU_in1,
	 input [31:0] ALU_in2,
	 input [4:0] shamt,
	 output reg [31:0] ALU_out,
	 output E_Ov,
	 output E_AdEL,
	 output E_AdES
    );
	 wire [32:0] a1 = {ALU_in1[31],ALU_in1};
	 wire [32:0] a2 = {ALU_in2[31],ALU_in2};
	 wire [32:0] calc_ans = (ALUop == `ALU_add)?a1 + a2:
	                        (ALUop == `ALU_sub)?a1 - a2:
									33'b0;
	 assign E_Ov = (calc_ans[32] != calc_ans[31] && calc && ov);
	 assign E_AdEL = (calc_ans[32] != calc_ans[31] && load);
	 assign E_AdES = (calc_ans[32] != calc_ans[31] && store);
	 wire [31:0] sra = $signed($signed(ALU_in1) >>> shamt);
	 wire [31:0] lui = {(ALU_in2[15:0]),16'b0};
	 always@(*)begin
	     case(ALUop)
		      `ALU_add:ALU_out <= ALU_in1 + ALU_in2;
				`ALU_sub:ALU_out <= ALU_in1 - ALU_in2;
				`ALU_or:ALU_out <=  ALU_in1 | ALU_in2;
				`ALU_lui:ALU_out <= lui;
				`ALU_and:ALU_out <= ALU_in1 & ALU_in2;
				`ALU_xor:ALU_out <= ALU_in1 ^ ALU_in2;
				`ALU_nor:ALU_out <= ~(ALU_in1 | ALU_in2);
				`ALU_sll:ALU_out <= ALU_in1 >> shamt;
				`ALU_srl:ALU_out <= ALU_in1 << shamt;
				`ALU_sra: ALU_out <= sra;
				`ALU_slt:ALU_out <= $signed(ALU_in1) < $signed(ALU_in2);
				`ALU_sltu:ALU_out <= ALU_in1 < ALU_in2;
				`ALU_addu:ALU_out <= ALU_in1 + ALU_in2;
				`ALU_subu:ALU_out <= ALU_in1 - ALU_in2;
		  endcase
	 end
/*	 assign ALU_out = (ALUop == `ALU_add) ? ALU_in1 + ALU_in2:
	                  (ALUo == `ALU_sub) ? ALU_in1 - ALU_in2:
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
*/

endmodule
