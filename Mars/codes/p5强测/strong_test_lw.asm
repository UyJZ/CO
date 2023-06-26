.text
########################################
#load
#R-E-RS
ori $s0,$0,20
ori $22 $0,4
add $21,$22,$22
ori $2,$0,8
sw $21,0($21)
add $22,$22,$22
sw $22,0($22)
lw $22,0($22)
#R-M-RS
add $21,$22,$22
ori $2,$0,8
sw $21,0($21)
add $22,$22,$22
nop
lw $22,0($22)
#R-W-RS
add $21,$22,$22
ori $2,$0,8
sw $21,0($21)
add $22,$22,$22
nop
nop
lw $22,0($22)
sw $22,0($22)
sw $22,4($0)
#I-E-RS
ori $1,$0,4
lw $2,0($1)
sw $2,0($1)
#I-M-RS
ori $1,$0,4
nop
lw $2,0($1)
sw $2,0($1)
#I-W-RS
ori $1,$0,4
nop
nop
lw $2,0($1)
sw $2,0($1)
nop
#jal-E-RS
ori $t1,$0,0x305c
sw $t1,0($0)
jal qqq1
lw $2,-0x30a0($ra)
p1:
j p2
qqq1:
nop
j p1
nop
p2:
nop
#jal-M-RS
ori $t1,$0,0x600
sw $t1,0($t1)
ori $1,4
jal qqq2
sw $s0,-0x30c4($ra)
q2:
j p3
qqq2:
lw $1,-0x30c4($ra)
j q2
nop
p3:
#jal-W-RS
jal qqq
nop
q3:
j p4
nop
qqq:
nop
lw $3,-0x30d0($ra)
j q3
nop
nop
p4:
#lw-E-RS
ori $2,$0,19420
sw $2,0($1)
lw $2,0($1)
lw $2,-19400($2)
#lw-M-RS
ori $2,$0,900
sw $2,0($1)
lw $1,0($1)
nop
lw $2,0($1)
sw $1,0($1)
#lw-W-Rs
ori $2,$0,100
sw $2,0($1)
lw $1,0($1)
nop
nop
lw $2,0($1)
sw $1,0($1)
#####################################

