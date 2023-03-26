`timescale 1ns / 1ps
`include "Control.v"
`include "ALU.v"
`include "DM.v"
`include "grf.v"
`include "NPC.v"
`include "PC.v"
`include "spitter.v"
`include "EXT.v"

module mips(
    input clk,
    input reset
    );
	 wire [31:0] pc,instr,npc,WD,RF_ans1,RF_ans2,ALU_in1,ALU_in2,ALU_out,DM_addr,DM_WD,DM_out,ra,pc_4,imm32;
	 wire [5:0] opcode,funct;
	 wire [4:0] rs,rt,rd,shamt,A1,A2,A3;
	 wire [15:0] imm16;
	 wire [25:0] imm26;
	 wire [2:0] ALUop;
	 wire [1:0] NPCop,WRsel,WDsel,DMsel,DMWr;
	 wire Zero,EXT_op,branch;
	 
	 PC _pc(
	 .pc(pc),
	 .npc(npc),
	 .clk(clk),
	 .reset(reset),
	 .instr(instr)
	 );
	 /*output reg [31:0] pc,
    input [31:0] npc,
    input clk,
    input reset,
	 output [31:0] instr*/
	 
	 NPC _npc(
	 .PC(pc),
	 .NPC(npc),
	 .ra(RF_ans1),
	 .imm26(imm26),
	 .Zero(Zero | branch),
	 .PC_4(pc_4),
	 .NPCop(NPCop)
	 );
	 /*input [31:0] PC,
    input [1:0] NPCop,
    input [31:0] ra,
    input [25:0] imm26,
	 input Zero,
    output [31:0] PC_4,
    output reg[31:0] NPC*/
	 
	 splitter _sp(
	 .in(instr),
	 .opcode(opcode),
	 .rs(rs),
	 .rt(rt),
	 .rd(rd),
	 .shamt(shamt),
	 .funct(funct),
	 .imm16(imm16),
	 .imm26(imm26)
	 );
	 /*input [31:0] in,
    output [5:0] opcode,
    output [4:0] rs,
    output [4:0] rt,
    output [4:0] rd,
    output [4:0] shamt,
    output [5:0] funct,
    output [15:0] imm16,
    output [25:0] imm26*/
	 
	 Control _ctrl(
	 .branch(branch),
	 .opcode(opcode),
	 .funct(funct),
	 .NPCop(NPCop),
	 .WRsel(WRsel),
	 .WDsel(WDsel),
	 .RFWr(RFWr),
	 .Bsel(Bsel),
	 .ALUop(ALUop),
	 .DMWr(DMWr),
	 .DMsel(DMsel),
	 .EXTop(EXT_op)
	 );
	 /*input [5:0] opcode,
    input [5:0] funct,
    output [1:0] NPCop,
    output [1:0] WRsel,
    output [1:0] WDsel,
    output RFWr,
    output EXTop,
    output Bsel,
    output [2:0] ALUop,
    output DMWr,
    output [1:0] DMsel*/
	 
	 
	 assign A3 = (WRsel == 0)?rt:
	             (WRsel == 1)?rd:
				 (WRsel == 2'b10)?5'b00000:
				 31;
	 assign WD = (WDsel == 0)?ALU_out:
	                 (WDsel == 1)?DM_out:
						                 pc_4;
	 assign A1 = rs,A2 = rt;
	 GRF _GRF(
	 .PC(pc),
	 .clk(clk),
	 .reset(reset),
	 .AD1(A1),
	 .AD2(A2),
	 .AD3(A3),
	 .WE(RFWr),
	 .WD(WD),
	 .OUT1(RF_ans1),
	 .OUT2(RF_ans2)
	 );
	 /*
	 input clk,
    input reset,
	 input [31:0] PC,
    input [4:0] AD1,
    input [4:0] AD2,
    input [4:0] AD3,
    input WE,
    input [31:0] WD,
    output [31:0] OUT1,
    output [31:0] OUT2
	 */
	 assign branch = (RF_ans2 <= 0);
	 assign ALU_in1 = RF_ans1;
	 assign ALU_in2 = (Bsel == 0)?RF_ans2:imm32;
	 
	 ALU _ALU(
	 .ALUop(ALUop),
	 .in_1(ALU_in1),
	 .in_2(ALU_in2),
	 .ALUout(ALU_out),
	 .Zero(Zero)
	 );
	 /*
    input [2:0] ALUop,
    input [31:0] in_1,
    input [31:0] in_2,
    output reg [31:0] ALUout,
	 output Zero*/
	 assign DM_addr = ALU_out;
	 DM _DM(
	 .PC(pc),
	 .clk(clk),
	 .reset(reset),
	 .DMsel(DMsel),
	 .addr(DM_addr),
	 .WD(RF_ans2),
	 .l_or_s(DMWr),
	 .DM_out(DM_out)
	 );
	 /*input clk,
	 input [31:0] PC,
    input reset,
    input [1:0] DMsel,
    input [31:0] addr,
    input [31:0] WD,
    input l_or_s,
    output [31:0] DM_out*/
	 
	 EXT _ext(
	 .in(imm16),
	 .op(EXT_op),
	 .out(imm32)
	 );
	 
	 /*input [15:0] in,
	 input op,
    output [31:0] out*/
	 
	 


endmodule
