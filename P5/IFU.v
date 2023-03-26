`timescale 1ns / 1ps
module IFU(
    output reg [31:0] pc,
    input [31:0] npc,
    input clk,
    input reset,
	 input WE,
	 output [31:0] instr
    );
    reg [31:0] ROM [8191:0];
    initial begin
	    pc <= 32'h0000_3000;
	    $readmemh("code.txt",ROM);
    end
	 always@(posedge clk)begin
	     if(reset)begin
		      pc <= 32'h0000_3000;
		  end
		  else if(WE)begin
		      pc <= npc;
		  end
	 end
	 wire [31:0] PC = pc - 32'h0000_3000;
	 assign instr = ROM[PC[31:2]];

endmodule
