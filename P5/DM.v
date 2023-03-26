`timescale 1ns / 1ps
module DM(
    input clk,
	 input [31:0] PC,
    input reset,
    input [1:0] DMsel,
    input [31:0] addr,
    input [31:0] WD,
    input [1:0]l_or_s,
    output [31:0] DM_out
    );
	 integer i;
	 reg [31:0] DM [4095:0];
	 wire [29:0] ADD_store = addr[31:2];
	 initial begin
	     for(i = 0;i < 4096;i = i + 1)begin
		      DM[i] <= 0;
		  end
	 end
	 always@(posedge clk)begin
	     if(reset == 1)begin
		      for(i = 0;i < 4096;i = i + 1)begin
				    DM[i] <= 32'h0000_0000;
				end
		  end
		  else begin
		      if(l_or_s == 2'b10)begin
				    case(DMsel)
					     2'b00:begin
						      $display("%d@%h: *%h <= %h",$time,PC, {ADD_store,2'b0}, WD);
						      DM[ADD_store] = WD;
						  end
						  2'b01:begin
						     if(addr[1] == 1)begin
							      DM[ADD_store] <= {WD[15:0],{DM[ADD_store][15:0]}};
						         $display("%d@%h: *%h <= %h", $time, PC, ADD_store, {WD[15:0],{DM[ADD_store][15:0]}});
							  end
							  else begin
							      DM[ADD_store] <= {{DM[ADD_store][31:16]},WD[15:0]};
						         $display("%d@%h: *%h <= %h", $time, PC, ADD_store, {{DM[ADD_store][31:16]},WD[15:0]});
							  end
						  end
						  2'b10:begin
						     case(addr[1:0])
							      2'b00:begin 
									    DM[ADD_store] <= {{DM[ADD_store][31:8]},WD[7:0]};
						             $display("%d@%h: *%h <= %h", $time, PC, ADD_store, {{DM[ADD_store][31:8]},WD[7:0]});
								   end
									2'b01:begin
									    DM[ADD_store] <= {{DM[ADD_store][31:16]},WD[7:0],{DM[ADD_store][7:0]}};
						             $display("%d@%h: *%h <= %h", $time, PC, ADD_store, {{DM[ADD_store][31:16]},WD[7:0],{DM[ADD_store][7:0]}});
									end
									2'b10:begin
									    DM[ADD_store] <= {{DM[ADD_store][31:24]},WD[7:0],{DM[ADD_store][15:0]}};
						             $display("%d@%h: *%h <= %h", $time, PC, ADD_store, {{DM[ADD_store][31:24]},WD[7:0],{DM[ADD_store][15:0]}});
									end
									2'b11:begin
									    DM[ADD_store] <= {WD[7:0],{DM[ADD_store][23:0]}};
						             $display("%d@%h: *%h <= %h", $time, PC, ADD_store, {WD[7:0],{DM[ADD_store][23:0]}});
									end
							  endcase
						  end
					 endcase
				end
		  end
	 end
	 assign DM_out = (l_or_s != 2'b01)?32'h0000_0000:
	                 (DMsel == 2'b00)?DM[ADD_store]:
	                 (DMsel == 2'b01 && addr[1] == 0)?{{16{DM[ADD_store][15]}},DM[ADD_store][15:0]}:
						  (DMsel == 2'b01 && addr[1] == 1)?{{16{DM[ADD_store][31]}},DM[ADD_store][31:16]}:
						  (DMsel == 2'b10 && addr[1:0] == 2'b00)?{{24{DM[ADD_store][7]}},DM[ADD_store][7:0]}:
						  (DMsel == 2'b10 && addr[1:0] == 2'b01)?{{24{DM[ADD_store][15]}},DM[ADD_store][15:8]}:
						  (DMsel == 2'b10 && addr[1:0] == 2'b10)?{{24{DM[ADD_store][23]}},DM[ADD_store][23:16]}:
						  (DMsel == 2'b10 && addr[1:0] == 2'b11)?{{24{DM[ADD_store][31]}},DM[ADD_store][31:24]}:
						  32'h0000_0000;


endmodule
