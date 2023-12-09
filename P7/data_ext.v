`timescale 1ns / 1ps
`include "const.v"
module data_ext(
    input load,
    input [31:0] M_ALU_out,
	 input M_AdEL_add,
    input [1:0] A,
	 input [31:0] Din,
	 input [2:0] Op,
	 input [31:0] PC_M,
	 output reg [31:0] Dout,
	 output M_AdEL
	 );
	 wire sign_byte = Din[A*8+7];
	 wire sign_half = Din[A[1]*16+15];
	 wire [31:0] a ={16*{sign_half},Din[31:16]};
	 assign flag = (M_ALU_out >= `StartInt && M_ALU_out <= `EndInt);
	 
	 assign error1 = (Op == 3'b000 && (|M_ALU_out[1:0]))|
	                 (Op == 3'b100 && (M_ALU_out[0]));
	 assign error2 = !((M_ALU_out >= `StartAddrDM && M_ALU_out <= `EndAddrDM)|
	                   (M_ALU_out >= `StartAddrTC1 && M_ALU_out <= `EndAddrTC1)| 
							 (M_ALU_out >= `StartAddrTC2 && M_ALU_out <= `EndAddrTC2)|
							 (M_ALU_out >= `StartInt && M_ALU_out <= `EndInt));
	 assign error3 = (Op != 3'b000 && M_ALU_out >= `StartAddrTC1 && !error2);
	 
	 assign M_AdEL = load & (error1 | error2 | error3 | M_AdEL_add);
	 
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
