`timescale 1ns / 1ps
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
	 output [1:0] RF_ad_sel,
	 output [1:0] RF_wd_sel,
	 output ALU_in2_sel,
	 output [3:0] ALUop,
	 output [2:0] rs_T_use,
	 output [2:0] rt_T_use,
	 output [2:0] E_T_new,
	 output [2:0] M_T_new,
	 output [1:0] WDsel,
	 output [4:0] RFDst,
	 output branch,
	 output [1:0] b_type,
	 output [2:0] NPCop
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
	 assign add = (special && funct == 6'b100000);
	 assign sub = (special && funct == 6'b100010);
	 assign jr = (special && funct == 6'b001000);
	 assign ori = (opcode == 6'b001101);
	 assign lw = (opcode == 6'b100011);
	 assign sw = (opcode == 6'b101011);
	 assign beq = (opcode == 6'b000100);
	 assign lui = (opcode == 6'b001111);
	 assign j = (opcode == 6'b000010);
	 assign jal = (opcode == 6'b000011);
	 assign lb = (opcode == 6'b100000);
	 assign lh = (opcode == 6'b100001);
	 assign sb = (opcode == 6'b101000);
	 assign sh = (opcode == 6'b101001);
	 assign DMWr = (sw | sb | sh )?2'b10:
	               (lw | lb | lh )?2'b01:
						2'b00;
	 assign DM_sel = (lb | sb)?2'b10:
	                (sh | lh)?2'b01:
						 2'b00;
	 assign NPCop = (jr)?3'b011:
	                (jal | j)?3'b010:
						 (beq)?3'b001:
						  3'b000;
	 assign RF_Wr = (add | sub | ori | lw | lui | jal);
	 assign EXT_OP = (lw | sw | beq);
	 assign ALU_in2_sel = (ori | lw | sw | lui);
	 assign ALUop = (lui)?4'b011:
	                (ori)?4'b010:
						 (beq | sub)?4'b001:
						 4'b000;
	assign rs_T_use = (add | sub | lw | sw | lb | lh | sb | sh | ori | lui)?3'b001:
	               (beq | jr | jal)?3'b000:
			 			3'b011;
	assign rt_T_use = ( add | sub )?3'b001:
	                  (sw | sh | sb | ori | lui)?3'b010:
	                  ( beq )?3'b000:
							3'b011;
	assign E_T_new = (add | sub | lui | ori)?3'b001:
	                 ( lw | lh | lb )?3'b010:
						  3'b000;
	assign M_T_new = (lw | lh | lb )?3'b001:
	                 3'b000;
	
	assign WDsel = (add | sub | lui | ori )?2'b01:
	               (lw | lh | lb )?2'b10:
						(jal)?2'b11:
						2'b00;
	assign RFDst = (add | sub)?rd:
	               (lui | ori | lw | lb | lh)?rt:
						( jal )?5'd31:
						5'd0;
	assign branch = (beq );
	assign b_type = (beq)?2'b00:
	                (jal)?2'b01:
						 2'b11;
	
endmodule
