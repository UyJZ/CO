`timescale 1ns / 1ps
`include "const.v"
module HILO(
    input clk,
	 input reset,
    input [31:0] in_1,
    input [31:0] in_2,
	 input [3:0] HILO_type,
	 output HILO_stall,
	 output [31:0] out
	 );
	 reg [4:0] state;
	 assign mult = (HILO_type == `mult);
	 assign multu = (HILO_type == `multu);
	 assign div = (HILO_type == `div);
	 assign divu = (HILO_type == `divu);
	 assign mfhi = (HILO_type == `mfhi);
	 assign mflo = (HILO_type == `mflo);
	 assign start = (mult | multu | divu | div);
	 wire [63:0] temp =  $signed(in_1) * $signed(in_2);
	 reg busy;
	 assign HILO_stall = busy | start;
	 reg [31:0] high,low,high_temp,low_temp;
	 assign out = (mfhi)?high:
	              (mflo)?low:
					  32'h0;
 	 always@(posedge clk)begin
	     if(reset)begin
		      high <= 0;
				low <= 0;
				state <= 0;
				busy <= 0;
		  end
		  else if(start)begin
		      busy <= 1;
		      case(HILO_type)
				    `mult:begin
					     {high_temp,low_temp} <= $signed(in_1) * $signed(in_2);
						  state <= 5;
					 end
					 `multu:begin
					     {high_temp,low_temp} <= in_1 * in_2;
						  state <= 5;
					 end
					 `div:begin
					     low_temp <= $signed(in_1) / $signed(in_2);
						  high_temp <= $signed(in_1) % $signed(in_2);
						  state <= 10;
					 end
					 `divu:begin
					     low_temp <= in_1/in_2;
						  high_temp <= in_1 % in_2;
						  state <= 10;
					 end
				endcase
		  end
		  else if(state == 1)begin
		      state = 0;
				high = high_temp;
				low = low_temp;
				busy <= 0;
		  end
		  else if(state > 1)begin
		      state = state - 1;
		  end
		  else if(state == 0)begin
		      case(HILO_type)
					`mthi:begin
						 high <= in_1; 
					end
					`mtlo:begin
						 low <= in_1;
					end
				endcase
		  end
	 end


endmodule
