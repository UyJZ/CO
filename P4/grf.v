`timescale 1ns / 1ps
module GRF(
    input clk,
    input reset,
	 input [31:0] PC,
    input [4:0] AD1,
    input [4:0] AD2,
    input [4:0] AD3,
    input WE,
    input [31:0] WD,
    output [31:0] OUT1,
    output [31:0] OUT2
    );
	 integer i;
	 reg [31:0] gpr [31:0];
	 initial begin
	     for(i = 0;i < 32;i = i + 1)begin
		      gpr[i] = 32'h0000_0000;
		  end
	 end
	 assign OUT1 = gpr[AD1];
	 assign OUT2 = gpr[AD2];
	 always@(posedge clk)begin
	     if(reset == 1)begin
		      for(i = 0;i < 32;i = i + 1)begin
				    gpr[i] <= 32'h0000_0000;
				end
		  end
		  else begin
		      if(AD3 != 5'b00000 && WE == 1)begin
				    $display("@%h: $%d <= %h", PC, AD3, WD);
				    gpr[AD3] <= WD;
				end
		  end
	 end


endmodule
