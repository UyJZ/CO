`timescale 1ns / 1ps
`define IM SR[15:10]//分别对应六个外部中断，相应位置1表示允许中断，置0表示禁止中断。这是一个被动的功能，只能通过mtc0这个指令修改，通过修改这个功能域，我们可以屏蔽一些中断。
`define EXL SR[1]//任何异常发生时置位，这会强制进入核心态（也就是进入异常处理程序）并禁止中断。
`define IE SR[0]//1表示允许中断
`define BD Cause[31]
`define IP Cause[15:10]
`define ExcCode Cause[6:2]
module CP0(
    input clk,
	 input reset,
	 input WE,
	 input [4:0] CP0Add,//CP0操作的地址
	 input [31:0] CP0In,//CP0输入的值
	 output [31:0] CP0Out,//CP0输出的值
	 input [31:0] VPC,//受害的PC
	 input BDIn,//是否是延迟槽中的指令
	 input [4:0] ExcCodeIn,//异常类型
	 input [5:0] HWInt,//输出中断信号
	 input EXLClr,//复位
	 output [31:0] EPCOut,//EPC
	 output Req//进入处理程序申请
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
