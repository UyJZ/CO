`timescale 1ns / 1ps
module NPC(
    input [31:0] PC,
    input [1:0] NPCop,
    input [31:0] ra,
    input [25:0] imm26,
	 input Zero,
    output [31:0] PC_4,
    output reg[31:0] NPC
    );
	 assign PC_4 = PC + 4;
	 always@(*)begin
	     case(NPCop)
		      2'b00:begin
				    NPC <= PC + 4;
				end
				2'b01:begin
				    if(Zero)begin
					     NPC <= PC + 4 + {{14{imm26[15]}},imm26[15:0],{2{1'b0}}};
					 end
					 else begin
					     NPC <= PC + 4;
					 end
				end
				2'b10:begin
				    NPC <= {{PC[31:28]},imm26,{2{1'b0}}};
				end
				2'b11:begin
				    NPC <= ra;
				end
		  endcase
		  
	 end
	 


endmodule
