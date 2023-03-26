`timescale 1ns / 1ps
`include "const.v"
module CTRL(
    input [31:0] instr,
	 output [4:0] rd,
	 output [4:0] rt,
	 output [4:0] rs,
	 output [15:0] imm16,
	 output [25:0] imm26,
	 output [4:0] shamt,
	 output [5:0] funct,
	 output [1:0] DMWr,
	 output [1:0] DM_sel,
	 output EXT_OP,
	 output RF_Wr,
	 output ALU_in2_sel,
	 output [3:0] ALUop,
	 output [2:0] rs_T_use,
	 output [2:0] rt_T_use,
	 output [2:0] E_T_new,
	 output [2:0] M_T_new,
	 output [2:0] WDsel,
	 output [4:0] RFDst,
	 output branch,
	 output [2:0] CMP_op,
	 output [2:0] NPCop,
	 output [3:0] HILO_type,
	 output [2:0] DATA_EXT
	 );
	 wire [5:0]opcode;
	 wire special,add,sub,jr,jal,j,lb,lh,lw,sb,sh,sw,ori,lui,beq;
	 assign opcode = {instr[31:26]};
	 assign rs = {instr[25:21]};
	 assign rt = {instr[20:16]};
	 assign rd = {instr[15:11]};
	 assign shamt = {instr[10:6]};
	 assign funct = {instr[5:0]};
	 assign imm16 = {instr[15:0]};
	 assign imm26 = {instr[25:0]};
	 assign special = (opcode == 6'b000000);
	 
/* 指令集*/	 
	 
	 assign add = (special && funct == 6'b100000);
	 assign sub = (special && funct == 6'b100010);
	 assign jr = (special && funct == 6'b001000);
	 assign ori = (opcode == 6'b001101);
	 assign lw = (opcode == 6'b100011);
	 assign sw = (opcode == 6'b101011);
	 assign beq = (opcode == 6'b000100);
	 assign lui = (opcode == 6'b001111);
	 assign j = (opcode == 6'b000010);
	 assign jal = (opcode == 6'b000011)?1'b1:1'b0;
	 assign lb = (opcode == 6'b100000);
	 assign lh = (opcode == 6'b100001);
	 assign sb = (opcode == 6'b101000);
	 assign sh = (opcode == 6'b101001);
	 assign mult = (special && funct == 6'b011000);
	 assign multu = (special && funct == 6'b011001);
	 assign div = (special && funct == 6'b011010);
	 assign divu = (special && funct == 6'b011011);
	 assign mfhi = (special && funct == 6'b010000);
	 assign mflo = (special && funct == 6'b010010);
	 assign mthi = (special && funct == 6'b010001);
	 assign mtlo = (special && funct == 6'b010011);
	 assign AND = (special && funct == 6'b100100);
	 assign OR = (special && funct == 6'b100101);
	 assign slt = (special && funct == 6'b101010);
	 assign sltu = (special && funct == 6'b101011);
	 assign andi = (opcode == 6'b001100);
	 assign bne = (opcode == 6'b000101);
	 assign addi = (opcode == 6'b001000);
	 
/*指令分类*/
    assign calc_r = (add | sub | slt | sltu | AND | OR);//寄存器运算	 
	 assign calc_i = (andi | ori | lui | addi);//寄存器与立即数运算
	 assign branch = (beq | bne);//条件跳转
	 assign jump_reg = (jr);//无条件跳转至寄存器
	 assign jump_imm = (j | jal);
	 assign jump_link = jal;
	 assign store = (sw | sb | sh);//储存
	 assign load = (lw | lh | lb);//取值
	 assign Half = (sh | lh);//半字
	 assign Byte = (lb | sb);//字节
	 assign Word = (sw | lw);
	 assign md = (mult | multu | div | divu);
	 assign mf = (mfhi | mflo );
	 assign mt = ( mthi | mtlo );
/*信号集*/	 
	 
	 assign DMWr = (store)?2'b10:
	               (load)?2'b01:
						2'b00;
	 assign DM_sel = (Byte)?2'b01:
	                 (Half)?2'b10:
						  (Word)?2'b11:
						  2'b00;
	 assign NPCop = (jump_reg)?3'b011:
	                (jump_imm)?3'b010:
						 (branch)?3'b001:
						  3'b000;
	 assign RF_Wr = (calc_i | calc_r | jump_link | load | mf);//寄存器堆的写使能
	 assign EXT_OP = (beq | load | store | bne | addi);
	 assign ALU_in2_sel = ( calc_i | store | load );//计算立即数
	 assign ALUop = (lui)?`ALU_lui:
	                (ori | OR)?`ALU_or:
						 (beq | sub)?`ALU_sub:
						 (AND | andi)?`ALU_and:
						 (slt )?`ALU_slt:
						 (sltu)?`ALU_sltu:
						 `ALU_add;
	assign rs_T_use = ( calc_r | calc_i | mt | md | store | load)?3'b001:
	                  (branch | jump_reg)?3'b000:
			 			   3'b011;
	assign rt_T_use = ( calc_r | md )?3'b001:
	                  ( store )?3'b010:
	                  ( branch )?3'b000:
							3'b011;
	assign E_T_new = ( calc_i | calc_r | mf )?3'b001:
	                 ( load )?3'b010:
						  3'b000;
	assign M_T_new = ( load )?3'b001:
	                 3'b000;
	
	assign WDsel = (calc_r | calc_i)?3'b001:
	               (load)?3'b010:
						(jal)?3'b011:
						(mf)?3'b100:
						3'b00;
	assign RFDst = (calc_r | mf)?rd:
	               (load | calc_i )?rt:
						( jal )?5'd31:
						5'd0;
	assign HILO_type = (mult)?4'b0000:
	                   (div)?4'b0001:
							 (multu)?4'b0010:
							 (divu)?4'b0011:
							 (mfhi)?4'b0100:
							 (mflo)?4'b0101:
							 (mthi)?4'b0110:
							 (mtlo)?4'b0111:
							 4'b1000;
	assign DATA_EXT = (lh)?3'b100:
	                  (lb)?3'b010:
							3'b000;
	assign CMP_op = (beq)?3'b000:
						 (bne)?3'b001:
						 3'bzzz;
	
endmodule
