.text
	# 61
	ori $t0,$0,0x300
	lui $t1,0x1234
	sw $t1,0x300($t0)
	add $t0,$t0,$t0
	lw $t2,0($t0)
	
	# 62
	lui $s0,0xbbdd
	sw $s0,4($0)
	ori $s1,$0,2
	add $s1,$s1,$s1
	nop
	lw $s2,0($s1)
	
	# 63
	lui $s0,0xffee
	sw $s0,4($0)
	ori $s1,$0,2
	add $s1,$s1,$s1
	nop
	nop
	lw $s2,0($s1)
	
	# 64
	lui $s1,0x1234
	sw $s1,200($0)
	ori $s2,$0,204
	lw $s3,-4($s2)
	
	# 65
	lui $s1,0x5678
	sw $s1,200($0)
	ori $s2,$0,208
	nop
	lw $s3,-8($s2)
	
	# 66
	lui $s1,0xabcd
	sw $s1,204($0)
	ori $s2,$0,212
	nop
	nop
	lw $s3,-8($s2)
	
	# 67
	sw $s3,4($0)
	jal label1
	lw $t0,-0x308c($ra)
	nop
	nop
	nop
label1:
	# 68
	jal label2
	nop
	nop
label2:
	lw $1,-0x30a0($ra)
	# 69
	jal label3
	nop
	nop
label3:
	nop
	lw $2,-0x30b0($ra)
	# 70
	ori $5,$0,8
	sw $5,0($0)
	lw $6,0($0)
	lw $4,-4($6)
	
	# 71
	ori $5,$0,12
	sw $5,8($0)
	lw $6,8($0)
	lw $30,-8($6)
	
	# 72
	ori $5,$0,16
	sw $5,12($0)
	lw $7,12($0)
	lw $29,-12($7)
	
	
	
	
	
	
	
	
	
	
	