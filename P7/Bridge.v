`timescale 1ns / 1ps
module Bridge(
    input interupt,
	 
	 output [31:0] m_data_rdata,
	 input [31:0] m_data_addr,
	 input [31:0] m_data_wdata,
	 input [3:0] m_data_byteen,
	 
	 input [31:0] temp_m_data_rdata,
	 output [31:0] temp_m_data_addr,
	 output [31:0] temp_m_data_wdata,
	 output [3:0] temp_m_data_byteen,
	 
	 input [31:0] m_int_addr,
	 input [3:0] m_int_byteen,
	 output [31:0] temp_m_int_addr,
	 output [3:0] temp_m_int_byteen,
	 
	 output [31:0] TC1_Addr,
	 output TC1_WE,
	 output [31:0] TC1_Din,
	 input [31:0] TC1_Dout,
	 
	 output [31:0] TC2_Addr,
	 output TC2_WE,
	 output [31:0] TC2_Din,
	 input [31:0] TC2_Dout
	 );
	 
	 assign TC1_WE = (m_data_addr >= 32'h0000_7f00 && m_data_addr <= 32'h0000_7f0b) & (|m_data_byteen);
	 assign TC2_WE = (m_data_addr >= 32'h0000_7f10 && m_data_addr <= 32'h0000_7f1b) & (|m_data_byteen);
	 
	 assign temp_m_data_addr = m_data_addr;
	 assign TC1_Addr = m_data_addr;
	 assign TC2_Addr = m_data_addr;
	 
	 assign TC1_Din = (TC1_WE)?m_data_wdata:0;
	 assign TC2_Din = (TC2_WE)?m_data_wdata:0;
	 
	 assign temp_m_int_addr = m_int_addr;
	 assign temp_m_int_byteen = m_int_byteen;
	 
	 assign temp_m_data_wdata = m_data_wdata;
	 assign temp_m_data_byteen = (TC1_WE || TC2_WE)?4'b0:
	                             m_data_byteen;
	 
	 assign m_data_rdata = (TC1_WE)?TC1_Dout:
	                       (TC2_WE)?TC2_Dout:
								  temp_m_data_rdata;


endmodule
