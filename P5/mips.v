`timescale 1ns / 1ps
`include "ALU.v"
`include "CMP.v"
`include "ctrl.v"
`include "DM.v"
`include "DREG.v"
`include "EREG.v"
`include "EXT.v"
`include "GRF.v"
`include "IFU.v"
`include "NPC.v"
`include "Stall_ctrl.v"
`include "const.v"
module mips(
    input clk,
    input reset
    );
	 wire [31:0] PC_F,PC_E,PC_D,PC_W,PC_M,NPC,instr_F,instr_D,instr_E,instr_M,instr_W;
	 wire [31:0] M_ALU_out,W_ALU_out,W_DM_out,M_DM_out;
	 wire STALL;
	 Stall_ctrl stall_ctrl(
	 .D_instr(instr_D),
    .E_instr(instr_E),
    .M_instr(instr_M),
	 .stall(STALL)
	 );
	 wire [31:0] E_RFWD, M_RFWD, W_RFWD;
    wire [4:0] E_RFDst, M_RFDst, W_RFDst;
    wire [1:0] E_RFWDsel, M_RFWDsel, W_RFWDsel;
    wire W_RFWE;

    assign E_RFWD = (E_RFWDsel == 2'b11) ? PC_E + 8 :
                    32'bz;

    assign M_RFWD = (M_RFWDsel == 2'b01) ? M_ALU_out :
                    (M_RFWDsel == 2'b11) ? PC_M + 8 :
                    32'bz;

    assign W_RFWD = (W_RFWDsel == 2'b01) ? W_ALU_out :
                    (W_RFWDsel == 2'b10) ? W_DM_out :
                    (W_RFWDsel == 2'b11) ? PC_W + 8 :
                    32'bz;
//**********stage F*************//
    IFU IFU(
	 .pc(PC_F),
	 .npc(NPC),
	 .clk(clk),
	 .reset(reset),
	 .WE(~STALL),
	 .instr(instr_F)
	 );
	 
//**********stage D*************//
	 DREG DREG(
	 .clk(clk),
	 .reset(reset),
	 .WE(~STALL),
	 .pc(PC_F),
	 .instr(instr_F),
	 .pc_out(PC_D),
	 .instr_out(instr_D)
	 );
	 
	 wire [4:0] D_rd_add,D_rt_add,D_rs_add;
	 wire [31:0] D_rd,D_rt,D_rs,D_EXTOUT;
	 wire [25:0] D_imm26;
	 wire [15:0] D_imm16;
	 wire [1:0] D_b_type;
	 wire [2:0] instr_NPC_op;
	 wire D_branch,D_EXTOP;
	 
	 CTRL D_CTRL(
	 .instr(instr_D),
	 .imm26(D_imm26),
	 .imm16(D_imm16),
	 .rd(D_rd_add),
	 .rt(D_rt_add),
	 .rs(D_rs_add),
	 .branch(D_branch),
	 .EXT_OP(D_EXTOP),
	 .b_type(D_b_type),
	 .NPCop(instr_NPC_op)
	 );
	 
	 GRF D_GRF(
	 .clk(clk),
	 .reset(reset),
	 .WE(GRF_WE),
	 .PC(PC_W),
	 .add1(D_rs_add),
	 .add2(D_rt_add),
	 .add_write(W_RFDst),
	 .WD(W_RFWD),
	 .GRF_out1(D_rs),
	 .GRF_out2(D_rt)
	 );
	 
	 EXT D_EXT(
	 .in(D_imm16),
	 .op(D_EXTOP),
	 .out(D_EXTOUT)
	 );
	 
	 wire [31:0] D_E_RS = (D_rs_add == 5'b0)?0:
								 (D_rs_add == E_RFDst)?E_RFWD:
								 (D_rs_add == M_RFDst)?M_RFWD:
								 D_rs;
								 
	 wire [31:0] D_E_RT = (D_rt_add == 5'b0)?0:
								 (D_rt_add == E_RFDst)?E_RFWD:
								 (D_rt_add == M_RFDst)?M_RFWD:
								 D_rt;
								 
	 wire [1:0] D_NPC_OP;
	 CMP D_CMP(
	 .REG_DATA1(D_E_RS),
	 .REG_DATA2(D_E_RT),
	 .CMP_OP(D_b_type),
	 .judge(D_branch),
	 .NPC_OP(D_NPC_OP)
	 );
	 
	 wire [2:0] D_NPC_sel = (D_branch == 1)?D_NPC_OP:instr_NPC_op;
	 
	 wire [31:0] D_PC_4;
	 NPC D_NPC(
	 .F_PC(PC_F),
	 .D_PC(PC_D),
	 .NPCop(D_NPC_sel),
	 .ra(D_E_RS),
	 .imm26(D_imm26),
	 .PC_4(D_PC_4),
	 .NPC(NPC)
	 );
//**********stage E*************//

    
	 wire [31:0] E_imm32,E_rs,E_rt;
	 EREG E_EGEG(
	 .GRF_data1(D_E_RS),
	 .GRF_data2(D_E_RT),
	 .instr(instr_D),
	 .pc(PC_D),
	 .clk(clk),
	 .reset(STALL | reset),
	 .WE(1'b1),
	 .imm32_in(D_EXTOUT),
	 .pc_out(PC_E),
	 .imm32_out(E_imm32),
	 .instr_out(instr_E),
	 .data1_out(E_rs),
	 .data2_out(E_rt)
	 );
	 
	 wire [3:0] E_ALUop;
	 wire E_ALU_in2_sel;
	 wire [4:0] E_rs_add,E_rt_add;
	 
	 CTRL E_ctrl(
	 .instr(instr_E),
	 .ALU_in2_sel(E_ALU_in2_sel),
	 .ALUop(E_ALUop),
	 .rs(E_rs_add),
	 .rt(E_rt_add),
	 .WDsel(E_RFWDsel),
	 .RFDst(E_RFDst)
	 );
	 
	 
	 wire [31:0] E_ALU_in1,E_ALU_in2,E_ALU_out,E_RS,E_RT;
	 
//forward	 
	 assign E_RS = (E_rs_add == 5'b0)?0:
					   (E_rs_add == M_RFDst)?M_RFWD:
	               (E_rs_add == W_RFDst)?W_RFWD:
						E_rs;
	 assign E_RT = (E_rt_add == 5'b0)?0:
					   (E_rt_add == M_RFDst)?M_RFWD:
	               (E_rt_add == W_RFDst)?W_RFWD:
						E_rt;
	 
	 
	 assign E_ALU_in1 = E_RS;
	 assign E_ALU_in2 = (E_ALU_in2_sel)?E_imm32:E_RT;
	
	 ALU E_ALU(
	 .ALUop(E_ALUop),
	 .ALU_in1(E_ALU_in1),
	 .ALU_in2(E_ALU_in2),
	 .ALU_out(E_ALU_out)
	 );


//**********stage M*************//


    wire [31:0] M_RT;
	 wire [4:0] M_rt_add;
	 MREG M_REG(
	 .clk(clk),
	 .reset(reset),
	 .WE(1'b1),
	 .PC_in(PC_E),
	 .PC_out(PC_M),
	 .instr_in(instr_E),
	 .instr_out(instr_M),
	 .ALU_in(E_ALU_out),
	 .ALU_out(M_ALU_out),
	 .rt(E_RT),
	 .rt_out(M_RT)
	 );
	 
	 wire [1:0] M_DMWr,M_DM_Sel;
	 
	 CTRL M_Ctrl(
	 .instr(instr_M),
	 .DMWr(M_DMWr),
	 .WDsel(M_RFWDsel),
	 .rt(M_rt_add),
	 .RFDst(M_RFDst),
	 .DM_sel(M_DM_Sel)
	 );
	 
	 wire [31:0] M_DM_WD = (M_rt_add == 0)?32'b0:
	                       (M_rt_add == W_RFDst)?W_RFWD:
								  M_RT;
	 
	 DM M_DM(
	 .clk(clk),
	 .PC(PC_M),
    .reset(reset),
    .DMsel(M_DM_Sel),
    .addr(M_ALU_out),
    .WD(M_DM_WD),
    .l_or_s(M_DMWr),
    .DM_out(M_DM_out)
	 );
	 
	 
//**********stage W*************//
    
	 wire [31:0] W_RT;
	 WREG W_reg(
    .clk(clk),
	 .reset(reset),
	 .WE(1'b1),
    .instr_M(instr_M),
	 .M_ALU_out(M_ALU_out),
	 .M_DM_out(M_DM_out),
	 .M_RT(M_RT),
	 .PC_M(PC_M),
	 .instr_W(instr_W),
	 .W_ALU_out(W_ALU_out),
	 .W_DM_out(W_DM_out),
	 .W_RT(W_RT),
	 .PC_W(PC_W)
	 );
	 
	 CTRL W_ctrl(
	 .instr(instr_W),
	 .RFDst(W_RFDst),
	 .RF_Wr(GRF_WE),
	 .WDsel(W_RFWDsel)
	 );
	 
	 




endmodule
