`timescale 1ns / 1ps
module Stall_ctrl(
    input [31:0] D_instr,
    input [31:0] E_instr,
    input [31:0] M_instr,
	 output stall
	 );
//stage D
    wire [2:0] rs_T_use,rt_T_use;
	 wire [4:0] rs_D_add,rt_D_add;
	 wire [4:0] E_RFDst,M_RFDst;
	 wire D_eret;
    CTRL D_ctrl(
	 .instr(D_instr),
	 .rs_T_use(rs_T_use),
	 .rt_T_use(rt_T_use),
	 .rs(rs_D_add),
	 .rt(rt_D_add),
	 .eret(D_eret)
	 );
//stage E

    wire [2:0] E_T_new;
	 wire [4:0] rs_E_add,rt_E_add,rd_E_add;
	 wire E_mtc0;
	 CTRL E_ctrl(
	 .instr(E_instr),
	 .E_T_new(E_T_new),
	 .rs(rs_E_add),
	 .rt(rt_E_add),
	 .RFDst(E_RFDst),
	 .mtc0(E_mtc0),
	 .rd(rd_E_add)
	 );
	 
//stage M
    wire [2:0] M_T_new;
	 wire [4:0] rs_M_add,rt_M_add,rd_M_add;
	 wire M_mtc0;
	 CTRL M_ctrl(
	 .instr(M_instr),
	 .M_T_new(M_T_new),
	 .rs(rs_M_add),
	 .rt(rt_M_add),
	 .RFDst(M_RFDst),
	 .mtc0(M_mtc0),
	 .rd(rd_M_add)
	 );
	 
	 wire stall_rs,stall_rt;
	 assign stall_rs = ((rs_T_use < E_T_new) &&(E_RFDst == rs_D_add)&&(rs_D_add != 0))|
	                   ((rs_T_use < M_T_new) &&(M_RFDst == rs_D_add)&&(rs_D_add != 0));
	 assign stall_rt = ((rt_T_use < E_T_new) &&(E_RFDst == rt_D_add)&&(rt_D_add != 0))|
	                   ((rt_T_use < M_T_new) &&(M_RFDst == rt_D_add)&&(rt_D_add != 0));
	 assign stall_eret = (D_eret) && ((E_mtc0 && rd_E_add == 14 ) || (M_mtc0 && rd_M_add == 14));
	 assign stall = stall_rs | stall_rt | stall_eret;
	 
	 
endmodule
