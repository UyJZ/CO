`timescale 1ns / 1ps
module ALU(
    input [2:0] ALUop,
    input [31:0] in_1,
    input [31:0] in_2,
    output reg [31:0] ALUout,
	 output Zero
    );
	 always@(*)begin
	    case(ALUop)
		     3'b000: ALUout <= in_1 + in_2;
			  3'b001: ALUout <= in_1 - in_2;
			  3'b010: ALUout <= in_1 | in_2;
			  3'b011: ALUout <= {{in_2[15:0]},{in_1[15:0]}};
			  3'b100: ALUout <= in_1 <<< (in_2);
		 endcase
	 end
	 assign Zero = (ALUop == 3'b001 && ALUout == 0);


endmodule
