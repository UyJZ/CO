`timescale 1ns / 1ps
module mips(
	 input clk,                    // 时钟信号
	 input reset,                  // 同步复位信号
	 input interrupt,              // 外部中断信号
	 output [31:0] macroscopic_pc, // 宏观 PC
	 output [31:0] i_inst_addr,    // IM 读取地址（取指 PC）
	 input  [31:0] i_inst_rdata,   // IM 读取数据
	 output [31:0] m_data_addr,    // DM 读写地址
	 input  [31:0] m_data_rdata,   // DM 读取数据
	 output [31:0] m_data_wdata,   // DM 待写入数据
	 output [3 :0] m_data_byteen,  // DM 字节使能信号
	 output [31:0] m_int_addr,     // 中断发生器待写入地址
	 output [3 :0] m_int_byteen,   // 中断发生器字节使能信号
	 output [31:0] m_inst_addr,    // M 级 PC
	 output w_grf_we,              // GRF 写使能信号
	 output [4 :0] w_grf_addr,     // GRF 待写入寄存器编号
	 output [31:0] w_grf_wdata,    // GRF 待写入数据
	 output [31:0] w_inst_addr     // W 级 PC
	 );
	 wire IRQ1,IRQ2;
	 wire [5:0] HWInt = {3'b0,interrupt,IRQ2,IRQ1};
	 
	 wire [31:0] temp_m_data_rdata,temp_m_data_wdata,TC1_Addr,TC2_Addr,TC1_Din,TC1_Dout,TC2_Din,TC2_Dout,temp_m_data_addr,temp_m_int_addr;
	 wire [3:0] temp_m_data_byteen,temp_m_int_byteen;
	 wire TC1_WE,TC2_WE;
	 
	 Bridge Bridge( 
	 .interupt(interupt),
	 
	 .m_data_rdata(temp_m_data_rdata),
	 .m_data_addr(temp_m_data_addr),
	 .m_data_wdata(temp_m_data_wdata),
	 .m_data_byteen(temp_m_data_byteen),
	 
	 .temp_m_data_rdata(m_data_rdata),
	 .temp_m_data_addr(m_data_addr),
	 .temp_m_data_wdata(m_data_wdata),
	 .temp_m_data_byteen(m_data_byteen),
	 
	 .temp_m_int_addr(m_int_addr),
	 .temp_m_int_byteen(m_int_byteen),
	 .m_int_addr(temp_m_int_addr),
	 .m_int_byteen(temp_m_int_byteen),
	 
	 .TC1_Addr(TC1_Addr),
	 .TC1_WE(TC1_WE),
	 .TC1_Din(TC1_Din),
	 .TC1_Dout(TC1_Dout),
	 
	 .TC2_Addr(TC2_Addr),
	 .TC2_WE(TC2_WE),
	 .TC2_Din(TC2_Din),
	 .TC2_Dout(TC2_Dout)
	 );
	 /*
	 input [31:0] m_data_addr,    // DM 读写地址
	 output  [31:0] m_data_rdata,   // DM 读取数据
	 input [31:0] m_data_wdata,   // DM 待写入数据
	 input [3 :0] m_data_byteen,  // DM 字节使能信号*/
	 
	 mips_CPU CPU(
	 .clk(clk),
    .reset(reset),
	 .HWInt(HWInt),
	 .i_inst_addr(i_inst_addr),//需要进行取指操作的流水级 PC（一般为 F 级）
	 .i_inst_rdata(i_inst_rdata),
	 .m_data_rdata(temp_m_data_rdata),
	 .m_data_addr(temp_m_data_addr),//待写入/读出的数据存储器相应地址
	 .m_data_wdata(temp_m_data_wdata),//待写入数据存储器相应数据
	 .m_data_byteen(temp_m_data_byteen),//四位字节使能
	 .m_inst_addr(m_inst_addr),//M 级 PC
	 .w_grf_we(w_grf_we),
    .w_grf_addr(w_grf_addr),
    .w_grf_wdata(w_grf_wdata),
    .w_inst_addr(w_inst_addr),
	 .m_int_addr(temp_m_int_addr),
	 .m_int_byteen(temp_m_int_byteen),
	 .macroscopic_pc(macroscopic_pc)
	 );
	 
	 TC TC1(
    .clk(clk),
    .reset(reset),
    .Addr(TC1_Addr),
    .WE(TC1_WE),
    .Din(TC1_Din),
    .Dout(TC1_Dout),
    .IRQ(IRQ1)//中断请求
	 );
	 
	 TC TC2(
    .clk(clk),
    .reset(reset),
    .Addr(TC2_Addr),
    .WE(TC2_WE),
    .Din(TC2_Din),
    .Dout(TC2_Dout),
    .IRQ(IRQ2)//中断请求
	 );


endmodule
