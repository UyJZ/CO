`timescale 1ns / 1ps
module MUX_2(
    input op,
	 input [31:0] in_1,
	 input [31:0] in_2,
	 output [31:0] out
	 );
	 assign out = (op == 0)?in_1:in_2;

endmodule


module MUX_4(
    input [1:0] op,
	 input [31:0] in_1,
	 input [31:0] in_2,
	 input [31:0] in_3,
	 input [31:0] in_4,
	 output [31:0] out
	 );
	 assign out = (op == 2'b00)?in_1:
	              (op == 2'b01)?in_2:
					  (op == 2'b10)?in_3:
					  in_4;

endmodule

