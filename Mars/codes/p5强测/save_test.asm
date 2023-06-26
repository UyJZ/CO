.text
	# 73
	ori $t1,$0,0x100
	add $t2,$t1,$t1
	sw $t1,-4($t2)
	
	# 74
	sub $t2,$t2,$t1
	sw $t2,-4($t2)
	
	# 75
	ori $t0,$0,0x240
	add $t2,$t1,$t0
	nop
	sw $t1,0($t2)
	
	# 76
	sub $t3,$t2,$t1
	nop
	sw $t3,-100($t2)
	
	# 77
	ori $t1,$0,0x330
	add $t2,$t1,$t1
	nop
	nop
	sw $t1,-16($t2)
	
	# 78
	sub $t3,$t1,$t2
	nop
	nop
	sw $t3,0($t2)
	
	# 79
	ori $s1,$0,0x400
	sw $t1,196($s1)
	
	# 80
	lui $s2,0xaabc
	sw $s2,-200($s1)
	
	# 81
	ori $t0,$0,0xab0
	nop
	sw $t1,200($t0)
	
	# 82
	lui $t1,0x1234
	nop
	sw $t1,-300($t0)
	
	# 83
	ori $t0,$0,0xcd0
	nop
	nop
	sw $t1,200($t0)
	
	# 84
	lui $t1,0x5678
	nop
	sw $t1,-300($t0)
	
	# 85
	jal label1
	sw $t1,-0x30a0($ra)
	nop
label2:
	# 87
	jal label3
	nop
label1:
	# 86
	jal label2
	sw $ra,-400($t0)
label4:
	sw $ra,-360($t0)
	#89
	jal label5
	nop
	nop
label3:
	sw $t0,-0x30a0($ra)
	# 88
	jal label4
	nop
label5:
	nop
	sw $t0,-0x30a4($ra)
	# 90
	jal label6
	nop
	nop
	nop
	nop
label6:
	nop
	sw $ra,0x300($0)
	# 91
	lw $s0,0x300($0)
	sw $ra,-0x30a0($s0)
	# 92
	lw $s1,-0x30a0($s0)
	sw $s1,0x124($0)
	
	lw $s2,0x300($0)
	sw $s2,-0x30b0($s2)
	
	#94
	lw $s4,0x300($0)
	nop
	sw $s4,-0x30b4($s2)
	
	# 93
	lw $s5,0x300($0)
	nop
	sw $s4,-0x30c0($s5)
	
	lw $s6,0x300($0)
	nop
	sw $s6,-0x30c8($s6)
	
	# 95
	lw $1,0x300($0)
	nop
	nop
	sw $1,-0x3000($s5)
	
	# 96
	lw $2,0x300($0)
	nop
	nop
	sw $s6,-0x3008($2)
	
	lw $3,0x300($0)
	nop
	nop
	sw $3,-0x3018($3)
	
	
	
	
	
	
	