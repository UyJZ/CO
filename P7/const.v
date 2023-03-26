`timescale 1ns / 1ps
//ALU
`define ALU_add 4'b0000
`define ALU_sub 4'b0001
`define ALU_lui 4'b0011
`define ALU_or 4'b0010
`define ALU_and 4'b0100
`define ALU_xor 4'b0101
`define ALU_nor 4'b0110
`define ALU_sll 4'b0111
`define ALU_srl 4'b1000
`define ALU_sra 4'b1001
`define ALU_slt 4'b1010
`define ALU_sltu 4'b1011
//EXT
`define EXT_unsigned 1'b0
`define EXT_signed 1'b1
//CMP
`define CMP_beq 3'b000
`define CMP_bne 3'b001
//CU
`define WD_ALU 2'b01
`define WD_load 2'b10
`define WD_pc_8 2'b11
//HILO
`define mult 4'b0000
`define div 4'b0001
`define multu 4'b0010
`define divu 4'b0011
`define mfhi 4'b0100
`define mflo 4'b0101
`define mthi 4'b0110
`define mtlo 4'b0111
//DM_ext
`define Byte 2'b01
`define Half 2'b10
`define Word 2'b11