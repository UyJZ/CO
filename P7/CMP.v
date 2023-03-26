`timescale 1ns / 1ps
`include "const.v"
module CMP(
    input [2:0] NPC_OP_in,
    input [31:0] REG_DATA1,
    input [31:0] REG_DATA2,
	 input [2:0] CMP_OP,
	 input branch,
    output reg [2:0] NPC_OP_out
    );
	 always@(*)begin
	     if(branch)begin
			  case(CMP_OP)
					`CMP_beq:begin
						 if(REG_DATA1 == REG_DATA2) NPC_OP_out <= 3'b001;
						 else NPC_OP_out <= 3'b000;
					end
					`CMP_bne:begin
						 if(REG_DATA1 == REG_DATA2) NPC_OP_out <= 3'b000;
						 else NPC_OP_out <= 3'b001;
					end
			  endcase
		  end
		  else begin
		      NPC_OP_out <= NPC_OP_in;
		  end
	 end


endmodule
