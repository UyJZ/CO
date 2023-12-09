`timescale 1ns / 1ps
module mips(
	 input clk,                    // ʱ���ź�
	 input reset,                  // ͬ����λ�ź�
	 input interrupt,              // �ⲿ�ж��ź�
	 output [31:0] macroscopic_pc, // ��� PC
	 output [31:0] i_inst_addr,    // IM ��ȡ��ַ��ȡָ PC��
	 input  [31:0] i_inst_rdata,   // IM ��ȡ����
	 output [31:0] m_data_addr,    // DM ��д��ַ
	 input  [31:0] m_data_rdata,   // DM ��ȡ����
	 output [31:0] m_data_wdata,   // DM ��д������
	 output [3 :0] m_data_byteen,  // DM �ֽ�ʹ���ź�
	 output [31:0] m_int_addr,     // �жϷ�������д���ַ
	 output [3 :0] m_int_byteen,   // �жϷ������ֽ�ʹ���ź�
	 output [31:0] m_inst_addr,    // M �� PC
	 output w_grf_we,              // GRF дʹ���ź�
	 output [4 :0] w_grf_addr,     // GRF ��д��Ĵ������
	 output [31:0] w_grf_wdata,    // GRF ��д������
	 output [31:0] w_inst_addr     // W �� PC
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
	 input [31:0] m_data_addr,    // DM ��д��ַ
	 output  [31:0] m_data_rdata,   // DM ��ȡ����
	 input [31:0] m_data_wdata,   // DM ��д������
	 input [3 :0] m_data_byteen,  // DM �ֽ�ʹ���ź�*/
	 
	 mips_CPU CPU(
	 .clk(clk),
    .reset(reset),
	 .HWInt(HWInt),
	 .i_inst_addr(i_inst_addr),//��Ҫ����ȡָ��������ˮ�� PC��һ��Ϊ F ����
	 .i_inst_rdata(i_inst_rdata),
	 .m_data_rdata(temp_m_data_rdata),
	 .m_data_addr(temp_m_data_addr),//��д��/���������ݴ洢����Ӧ��ַ
	 .m_data_wdata(temp_m_data_wdata),//��д�����ݴ洢����Ӧ����
	 .m_data_byteen(temp_m_data_byteen),//��λ�ֽ�ʹ��
	 .m_inst_addr(m_inst_addr),//M �� PC
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
    .IRQ(IRQ1)//�ж�����
	 );
	 
	 TC TC2(
    .clk(clk),
    .reset(reset),
    .Addr(TC2_Addr),
    .WE(TC2_WE),
    .Din(TC2_Din),
    .Dout(TC2_Dout),
    .IRQ(IRQ2)//�ж�����
	 );


endmodule
