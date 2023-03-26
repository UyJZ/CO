`timescale 1ns / 1ps
module PC(
    output reg [31:0] pc,
    input [31:0] npc,
    input clk,
    input reset,
	 output [31:0] instr
    );
	 reg [31:0] ROM [1023:0];
	 integer i;
	 initial begin
	     pc <= 32'h0000_3000;
		  $readmemh("code.txt",ROM);
	 end
	 always@(posedge clk ) begin
	     if(reset == 1) begin
		      pc <= 32'h0000_3000;
		  end
		  else begin
		      pc <= npc;
		  end
	 end
	 
	 assign instr = ROM[pc[11:2]];

endmodule
