`timescale 1ns / 1ps
module Control(
    input branch,
    input [5:0] opcode,
    input [5:0] funct,
    output [1:0] NPCop,
    output [1:0] WRsel,
    output [1:0] WDsel,
    output RFWr,
    output EXTop,
    output Bsel,
    output [2:0] ALUop,
    output [1:0]DMWr,
    output [1:0] DMsel
    );
	 wire special,add,sub,jr,jal,j,lb,lh,lw,sb,sh,sw,ori,lui,beq;
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
	 assign jal = (opcode == 6'b000011)?1'b1:1'b0;
	 assign lb = (opcode == 6'b100000);
	 assign lh = (opcode == 6'b100001);
	 assign sb = (opcode == 6'b101000);
	 assign sh = (opcode == 6'b101001);
	 assign bltzal = (opcode == 6'b000001);
	 assign NPCop = (jr)?2'b11:
	                (jal | j)?2'b10:
						 (beq | bltzal)?2'b01:
						  2'b00;
	 assign WRsel = (jal | (bltzal && branch))?2'b11:
	                (add | sub)?2'b01:
						 2'b00;
	 assign WDsel = (jal | (bltzal && branch))?2'b10:
	                (lw)?2'b01:
						 2'b00;
	 assign RFWr = (add | sub | ori | lw | lui | jal | (bltzal && branch));
	 assign EXTop = (lw | sw | beq);
	 assign Bsel = (ori | lw | sw | lui);
	 assign ALUop = (lui)?3'b011:
	                (ori)?3'b010:
						 (beq | sub)?3'b001:
						 3'b000;
	 assign DMWr = (sw | sb | sh )?2'b10:
	               (lw | lb | lh )?2'b01:
						2'b00;
	 assign DMsel = (lb | sb)?2'b10:
	                (sh | lh)?2'b01:
						 2'b00;


endmodule
