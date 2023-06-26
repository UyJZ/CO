.text
	# 49
	ori $s0,$0,0x3014
	add $s1,$s0,$0
	jr $s1
	nop
	nop
label1:
	ori $s0,$0,0x3038
	ori $s1,$0,4
	sub $s2,$s0,$s1
	jr $s2
	# 50
	ori $t0,$0,0x305c
	nop
	nop
	nop
label2:
	ori $t1,$0,4
	sub $t0,$t0,$t1
	nop
	jr $t0
	ori $1,$0,0x3044
label4:
	# 52
	ori $3,$0,0x306c
	jr $3
	# 53
	ori $3,$0,0x3080
	nop
label3:
	# 51
	add $2,$1,$t1
	nop
	nop
	jr $2
	nop
label5:
	nop
	jr $3
	nop
label7:
	jal label8
	nop
label6:
	# 54
	ori $3,$0,0x3078
	nop
	nop
	jr $3
	nop
label8:
	# 56
	jal label9
	nop
	# 57
	jal label10
	nop
	sw $30,100($0)
	lw $2,100($0)
	jr $2
	nop
label9:
	jr $ra
	nop
label10:
	nop
	jr $ra
	# 58
	ori $30,$0,0x30c8
label11:
	# 59
	ori $27,$0,0x30e8
	sw $27,300($0)
	lw $26,300($0)
	nop
	jr $26
	nop
	nop
	nop
label12:
	# 60
	ori $25,$0,0x310c
	sw $25,500($0)
	lw $24,500($0)
	nop
	nop
	jr $24
	add $23,$24,$24
	nop
	nop
label13:
	sub $25,$24,$23
