`timescale 1ns / 1ps
`define IM SR[15:10]//�ֱ��Ӧ�����ⲿ�жϣ���Ӧλ��1��ʾ�����жϣ���0��ʾ��ֹ�жϡ�����һ�������Ĺ��ܣ�ֻ��ͨ��mtc0���ָ���޸ģ�ͨ���޸�������������ǿ�������һЩ�жϡ�
`define EXL SR[1]//�κ��쳣����ʱ��λ�����ǿ�ƽ������̬��Ҳ���ǽ����쳣������򣩲���ֹ�жϡ�
`define IE SR[0]//1��ʾ�����ж�
`define BD Cause[31]
`define IP Cause[15:10]
`define ExcCode Cause[6:2]
module CP0(
    input clk,
	 input reset,
	 input WE,
	 input [4:0] CP0Add,//CP0�����ĵ�ַ
	 input [31:0] CP0In,//CP0�����ֵ
	 output [31:0] CP0Out,//CP0�����ֵ
	 input [31:0] VPC,//�ܺ���PC
	 input BDIn,//�Ƿ����ӳٲ��е�ָ��
	 input [4:0] ExcCodeIn,//�쳣����
	 input [5:0] HWInt,//����ж��ź�
	 input EXLClr,//��λ
	 output [31:0] EPCOut,//EPC
	 output Req//���봦���������
	 );
	 reg [31:0] SR,Cause,EPC;
	 
	 assign ExceptionReq = (!`EXL && (|ExcCodeIn));
	 
	 assign BreakReq = (!`EXL && `IE && (|(HWInt & `IM)));
	 
	 assign Req = ExceptionReq | BreakReq;
	 
	 wire [31:0] temp_EPC = (Req)?((BDIn)?VPC - 4:VPC)
	                            : EPC;
	 
	 initial begin
	 
	     SR <= 32'h0;
		  Cause <= 32'h0;
		  EPC <= 32'h0;
	 
	 end
	 
	 always@(posedge clk)begin
	 
	     if(reset)begin
		      SR <= 32'h0;
				Cause <= 32'h0;
				EPC <= 32'h0;
		  end
		  else begin
		      if(EXLClr)begin
				    `EXL <= 0;
				end
				if(Req)begin
				    `ExcCode <= (BreakReq)?5'b0:ExcCodeIn;
					 `EXL <= 1;
					 EPC <= temp_EPC;
					 `BD <= BDIn;
				end
				else if(WE)begin
				    case(CP0Add)
					      12: SR <= CP0In;
							14: EPC <= CP0In;
					 endcase
				end
				`IP <= HWInt;
		  end
	 
	 end
	 assign EPCOut = temp_EPC;
	 
	 assign CP0Out = (CP0Add == 12)?SR:
	                 (CP0Add == 13)?Cause:
						  (CP0Add == 14)?EPC:
						  32'h0; 


endmodule
