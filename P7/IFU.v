`timescale 1ns / 1ps
module IFU(
    output reg [31:0] pc,
    input [31:0] npc,
    input clk,
    input reset,
	 input WE,
	 input Req,
	 output [31:0] instr
    );
    reg [31:0] ROM [1023:0];
    initial begin
	    pc <= 32'h0000_3000;
	    $readmemh("code.txt",ROM);
    end
	 always@(posedge clk)begin
	     if(reset)begin
		      pc <= 32'h0000_3000;
		  end
		  else if(WE || Req)begin
		      pc <= npc;
		  end
	 end
	 assign instr = ROM[pc[11:2]];

endmodule
