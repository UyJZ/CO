`timescale 1ns / 1ps
module NPC(
    input [31:0] F_PC,
    input [31:0] D_PC,
	 input [31:0] EPC,
    input [2:0] NPCop,
    input [31:0] ra,
    input [25:0] imm26,
    output [31:0] PC_4,
    output reg[31:0] NPC
    );
	 assign PC_4 = F_PC + 4;
	 always@(*)begin
	     case(NPCop)
		      3'b000:begin
				    NPC <= F_PC + 4;
				end
				3'b001:begin
					 NPC <= D_PC + 4 + {{14{imm26[15]}},imm26[15:0],{2{1'b0}}};
				end
				3'b010:begin
				    NPC <= {{D_PC[31:28]},imm26,{2{1'b0}}};
				end
				3'b011:begin
				    NPC <= ra;
				end
				3'b100:begin
				    NPC <= EPC + 4;
				end
		  endcase
		  
	 end
	 


endmodule
