`timescale 1ns / 1ps
module splitter(
    input [31:0] in,
    output [5:0] opcode,
    output [4:0] rs,
    output [4:0] rt,
    output [4:0] rd,
    output [4:0] shamt,
    output [5:0] funct,
    output [15:0] imm16,
    output [25:0] imm26
    );
	 assign opcode = {in[31:26]};
	 assign rs = {in[25:21]};
	 assign rt = {in[20:16]};
	 assign rd = {in[15:11]};
	 assign shamt = {in[10:6]};
	 assign funct = {in[5:0]};
	 assign imm16 = {in[15:0]};
	 assign imm26 = {in[25:0]};


endmodule
