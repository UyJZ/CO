.text
#save
#R-E-RS
ori $s0,$0,8
ori $1,$1,8
add $2,$1,$1
sw $2,-4($2)
#R-E-RT
ori $1,4
add $2,$1,$1
sw $1,0($2)
#R-M-RS
ori $1,8
add $2,$1,$1
nop
sw $2,-4($2)
#R-M-RT
add $2,$1,$1
nop
sw $1,-8($2)
#R-W-RS
ori $t1,16
add $2,$1,$1
nop
nop
sw $2,-16($2)
#R-W-RT
add $2,$1,$1
nop
nop
sw $1,-4($2)
#I-E-RS
ori $2,$1,6
sw $2,2($2)
#I-E-RT
ori $2,$1,6
sw $2,4($0)
#I-M-RS
ori $2,$1,6
nop
sw $2,2($2)
#I-M-RT
ori $2,$1,6
nop
sw $2,4($0)
#I-W-RS
ori $2,$1,6
nop
nop
sw $2,2($2)
#I-W-RT
ori $2,$1,6
nop
nop
sw $2,4($0)

#jal-E-RS
jal qq0
sw $ra,-0x309c($ra)
q0:
j qqq0
nop
qq0:
j q0
nop
qqq0:
#jal-E-RT
jal qq1
sw $ra,4($0)
q1:
j qqq1
nop
qq1:
j q1
nop
qqq1:
#jal-M-RS
nop
jal qq2
nop
q2:
j qqq2
nop
qq2:
sw $ra,-0x30a0($ra)
j q2
nop
qqq2:
#jal-W-RS
nop
jal qq3
nop
q3:
j qqq3
nop
qq3:
nop
sw $ra,-0x30b0($ra)
j q3
nop
qqq3:

#jal-M-RT
jal qq11
nop
q11:
j qqq11
nop
qq11:
sw $ra,4($0)
j q11
nop
qqq11:
#jal-W-RT
jal qq111
nop
q111:
j qqq111
nop
qq111:
nop
sw $ra,4($0)
j q111
nop
qqq111:



#load-E-RS
sw $s0,0($0)
ori $1,$0,400
lw $2,0($0)
sw $1,0($2)
#load-E-RT
lw $2,0($0)
sw $2,-40($1)
#load-M-RS
ori $1,$0,400
lw $2,0($0)
nop
sw $1,0($2)
#load-M-RT
lw $2,0($0)
nop
sw $2,-40($1)
#load-W-RS
ori $1,$0,400
lw $2,0($0)
nop
nop
sw $1,0($2)
#load-W-RT
lw $2,0($0)
nop
nop
sw $2,-40($1)
