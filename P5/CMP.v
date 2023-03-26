`timescale 1ns / 1ps
`include "const.v"
module CMP(
    input [31:0] REG_DATA1,
    input [31:0] REG_DATA2,
	 input [1:0] CMP_OP,
	 input judge,
    output reg [1:0] NPC_OP
    );
	 always@(*)begin
	    if(judge == 1)begin
		     case(CMP_OP)
			      `CMP_beq:begin
					    if(REG_DATA1 == REG_DATA2)begin
						     NPC_OP <= 2'b01;
						 end
						 else begin
						     NPC_OP <= 2'b00;
						 end
					end
					default: NPC_OP <= 2'b00;
			  endcase
		 end
		 else NPC_OP <= 2'b00;
	 end


endmodule
