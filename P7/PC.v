`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:32:01 11/14/2022 
// Design Name: 
// Module Name:    PC 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module PC(
    output reg [31:0] pc,
    input [31:0] npc,
    input clk,
    input reset,
	 input WE,
	 input Req
	 );
	 always@(posedge clk)begin
	     if(reset)begin
		      pc <= 32'h0000_3000;
		  end
		  else if(WE | Req)begin
		      pc <= Req?32'h0000_4180:npc;
		  end
	 end


endmodule
