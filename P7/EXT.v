`timescale 1ns / 1ps
module EXT(
    input [15:0] in,
	 input op,
    output [31:0] out
    );
	 assign out = (op == 1)?{{16{in[15]}},in}:{{16{1'b0}},in};


endmodule
