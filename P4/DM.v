`timescale 1ns / 1ps
module DM(
    input clk,
	 input [31:0] PC,
    input reset,
    input [1:0] DMsel,
    input [31:0] addr,
    input [31:0] WD,
    input [1:0]l_or_s,
    output reg [31:0] DM_out
    );
	 integer i;
	 assign Byte = (addr[1:0] == 2'b00);
	 reg [31:0] DM [1023:0];
	 initial begin
	     for(i = 0;i < 1024;i = i + 1)begin
		      DM[i] <= 0;
		  end
	 end
	 always@(posedge clk)begin
	     if(reset == 1)begin
		      for(i = 0;i < 1024;i = i + 1)begin
				    DM[i] <= 32'h0000_0000;
				end
		  end
		  else begin
		      if(l_or_s == 2'b10)begin
				    case(DMsel)
					     2'b00:begin
						      $display("@%h: *%h <= %h", PC, addr, WD);
						      DM[addr[11:2]] = WD;
						  end
						  2'b01:begin
						     if(addr[1] == 1)begin
							      DM[addr[11:2]] <= {WD[15:0],{DM[addr[11:2]][15:0]}};
						         $display("@%h: *%h <= %h", PC, addr, {WD[15:0],{DM[addr[11:2]][15:0]}});
							  end
							  else begin
							      DM[addr[11:2]] <= {{DM[addr[11:2]][31:16]},WD[15:0]};
						         $display("@%h: *%h <= %h", PC, addr, {{DM[addr[11:2]][31:16]},WD[15:0]});
							  end
						  end
						  2'b10:begin
						     case(addr[1:0])
							      2'b00:begin 
									    DM[addr[11:2]] <= {{DM[addr[11:2]][31:8]},WD[7:0]};
						             $display("@%h: *%h <= %h", PC, addr, {{DM[addr[11:2]][31:8]},WD[7:0]});
								   end
									2'b01:begin
									    DM[addr[11:2]] <= {{DM[addr[11:2]][31:16]},WD[7:0],{DM[addr[11:2]][7:0]}};
						             $display("@%h: *%h <= %h", PC, addr, {{DM[addr[11:2]][31:16]},WD[7:0],{DM[addr[11:2]][7:0]}});
									end
									2'b10:begin
									    DM[addr[11:2]] <= {{DM[addr[11:2]][31:24]},WD[7:0],{DM[addr[11:2]][15:0]}};
						             $display("@%h: *%h <= %h", PC, addr, {{DM[addr[11:2]][31:24]},WD[7:0],{DM[addr[11:2]][15:0]}});
									end
									2'b11:begin
									    DM[addr[11:2]] <= {WD[7:0],{DM[addr[11:2]][23:0]}};
						             $display("@%h: *%h <= %h", PC, addr, {WD[7:0],{DM[addr[11:2]][23:0]}});
									end
							  endcase
						  end
					 endcase
				end
		  end
	 end
	 
	 wire [31:0] Write = DM[addr[11:2]];
	 wire [5:0] AD = {3'b0,addr[1:0]} << 3;

always@(*)begin
	  DM_out <= (l_or_s != 2'b01)?32'h0000_0000:
	                 (DMsel == 2'b00)?DM[addr[11:2]]:
	                 (DMsel == 2'b01 && addr[1] == 0)?{{16{DM[addr[11:2]][15]}},DM[addr[11:2]][15:0]}:
						  (DMsel == 2'b01 && addr[1] == 1)?{{16{DM[addr[11:2]][31]}},DM[addr[11:2]][31:16]}:
						  (DMsel == 2'b10 && addr[1:0] == 2'b00)?{{24{DM[addr[11:2]][7]}},DM[addr[11:2]][7:0]}:
						  (DMsel == 2'b10 && addr[1:0] == 2'b01)?{{24{DM[addr[11:2]][15]}},DM[addr[11:2]][15:8]}:
						  (DMsel == 2'b10 && addr[1:0] == 2'b10)?{{24{DM[addr[11:2]][23]}},DM[addr[11:2]][23:16]}:
						  (DMsel == 2'b10 && addr[1:0] == 2'b11)?{{24{DM[addr[11:2]][31]}},DM[addr[11:2]][31:24]}:
						  (DMsel == 2'b11 && Byte == 1)?DM[addr[11:2]]:
						  (DMsel == 2'b11 && AD == 8)?{{Write[7:0]},{Write[31:8]}}:
						  (DMsel == 2'b11 && AD == 16)?{{Write[15:0]},{Write[31:16]}}:
						  (DMsel == 2'b11 && AD == 24)?{{Write[23:0]},{Write[31:24]}}:
						  (DMsel == 2'b11 && AD == 32)?{{Write[31:0]}}:
						  32'h0000_0000;
	 end
endmodule
