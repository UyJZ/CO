`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:04:57 11/14/2022 
// Design Name: 
// Module Name:    data_ext 
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
module data_ext(
    input [1:0] A,
	 input [31:0] Din,
	 input [2:0] Op,
	 output reg [31:0] Dout
	 );
	 wire sign_byte = Din[A*8+7];
	 wire sign_half = Din[A[1]*16+15];
	 wire [31:0] a ={16*{sign_half},Din[31:16]};
	 always@(*)begin
	     case(Op)
		      3'b000:begin
				    Dout <= Din;
				end
				3'b001:begin
				    case(A)
					     2'b00: Dout <= {24'b0,Din[7:0]};
						  2'b01: Dout <= {24'b0,Din[15:8]};
						  2'b10: Dout <= {24'b0,Din[23:16]};
						  2'b11: Dout <= {24'b0,Din[31:24]};
					 endcase
				end
				3'b010:begin
				    case(A)
					     2'b00: Dout <= {{24{sign_byte}},Din[7:0]};
						  2'b01: Dout <= {{24{sign_byte}},Din[15:8]};
						  2'b10: Dout <= {{24{sign_byte}},Din[23:16]};
						  2'b11: Dout <= {{24{sign_byte}},Din[31:24]};
					 endcase
				end
				3'b011:begin
				    case(A)
					     2'b00: Dout <= {16'b0,Din[15:0]};
						  2'b10: Dout <= {16'b0,Din[31:16]};
					 endcase
				end
				3'b100:begin
				    case(A)
					     2'b00: Dout <= {{16{sign_half}},Din[15:0]};
						  2'b10: Dout <= {{16{sign_half}},Din[31:16]};
					 endcase
				end
		  endcase
	 end


endmodule
