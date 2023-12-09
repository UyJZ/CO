`timescale 1ns / 1ps
`include "const.v"
module DM_ext(
    input [31:0] PC_M,
	 input store,
	 input Req,
    input M_AdES_add,
	 input [31:0] M_ALU_out,
	 input [31:0] in,
	 input [1:0] DMWr,
	 input [1:0] DMSel,
	 output reg [31:0] out,
	 output reg [3:0] m_data_byteen,
	 output M_AdES
	 );
	 
	 assign error1 = (DMSel == `Word && (|M_ALU_out[1:0]))|
	                 (DMSel == `Half && (M_ALU_out[0]));
	 assign error2 = !((M_ALU_out >= `StartAddrDM && M_ALU_out <= `EndAddrDM)|
	                   (M_ALU_out >= `StartAddrTC1 && M_ALU_out <= `EndAddrTC1 - 4)| 
							 (M_ALU_out >= `StartAddrTC2 && M_ALU_out <= `EndAddrTC2 - 4)|
							 (M_ALU_out >= `StartInt && M_ALU_out <= `EndInt));
	 assign error3 = (DMSel != `Word && M_ALU_out >= `StartAddrTC1 && !error2);
/*	 assign error3 = (PC_M >= 32'h0000_4180)?((M_ALU_out >= `StartAddrTC1 && M_ALU_out <= `EndAddrTC1)
	                                         |(M_ALU_out >= `StartAddrTC2 && M_ALU_out <= `EndAddrTC2)):
	                                          (M_ALU_out >= `StartAddrTC1);*/
	 
	 assign M_AdES = store & (error1 | error2 | error3 | M_AdES_add);
	 
	 always@(*)begin
	     case(DMSel)
		      `Word:begin
				    out <= in;
				end
				`Half:begin
				    case(M_ALU_out[1])
					     0: begin
						      out <= {16'b0,in[15:0]};
						  end
						  1: begin
						      out <= {in[15:0],16'b0};
						  end
					 endcase
				end
				`Byte:begin
				    case(M_ALU_out[1:0])
					     2'b00: begin
						      out <= {24'b0,in[7:0]};
						  end
						  2'b01: begin
						      out <= {16'b0,in[7:0],8'b0};
						  end
						  2'b10: begin
						      out <= {8'b0,in[7:0],16'b0};
						  end
						  2'b11: begin
						      out <= {in[7:0],24'b0};
						  end
					 endcase
				end
		  endcase
	 end
	 
	 always@(*)begin
	     if(M_AdES | Req)begin
		      m_data_byteen <= 4'b0000;
		  end
		  else if(DMWr == 2'b10)begin
		      case(DMSel)
				    `Word: m_data_byteen <= 4'b1111;
					 `Half: begin
					     case(M_ALU_out[1])
						      0: m_data_byteen <= 4'b0011;
								1: m_data_byteen <= 4'b1100;
						  endcase
					 end
					 `Byte: begin
					     case(M_ALU_out[1:0])
						      2'b00: m_data_byteen <= 4'b0001;
								2'b01: m_data_byteen <= 4'b0010;
								2'b10: m_data_byteen <= 4'b0100;
								2'b11: m_data_byteen <= 4'b1000;
						  endcase
					 end
					 default: m_data_byteen <= 4'b0000;
				endcase
		  end
		  else m_data_byteen <= 4'b0000;
	 end


endmodule
