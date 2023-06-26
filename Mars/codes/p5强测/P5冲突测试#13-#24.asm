.text
	#13
	ori $t0,$0,0xadce
	sw $t0,12($0)
	ori $t1,$t0,0xdefa
	sw $t1,8($0)
	
	ori $t3,$0,4
	lw $t2,8($t3)
	add $t4,$t2,$t0
	
	ori $t3,$0,15
	lw $t4,-7($t3)
	sub $t5,$t4,$t2
	
	#14
	ori $t0,$0,0xefac
	sw $t0,12($0)
	ori $t1,$t0,0xfead
	sw $t1,8($0)
	
	ori $t3,$0,4
	lw $t2,8($t3)
	add $t4,$t0,$t2
	
	ori $t3,$0,21
	lw $t4,-13($t3)
	sub $t5,$t2,$t4
	
	#15
	ori $t0,$0,0x0ace
	sw $t0,12($0)
	ori $t1,$t0,0x00a1
	sw $t1,8($0)
	
	ori $t3,$0,4
	lw $t2,8($t3)
	nop
	add $t4,$t2,$t0
	
	ori $t3,$0,15
	lw $t4,-7($t3)
	nop
	sub $t5,$t4,$t2
	
	#16
	lui $t0,0x1234
	sw $t0,12($0)
	lui $t1,0xfead
	sw $t1,8($0)
	
	ori $t3,$0,4
	lw $t2,8($t3)
	nop
	add $t4,$t0,$t2
	
	ori $t3,$0,25
	lw $t4,-17($t3)
	nop
	sub $t5,$t2,$t4
	
	#17
	lui $1,0x13ac
	ori $2,0x12ae
	
	add $3,$1,$2
	ori $4,$3,0xcd12
	
	sub $5,$4,$1
	ori $6,$5,0x4589
	
	#18
	lui $1,0x56ed
	ori $2,0x349a
	
	add $3,$1,$2
	nop
	ori $4,$3,0xc102
	
	sub $5,$4,$1
	nop
	ori $6,$5,0x4ea9
	
	#19
	lui $7,0x1345
	ori $8,$7,0x1122
	
	ori $9,$8,0x3344
	ori $10,$9,0x00ff
	
	#20
	lui $7,0x2211
	nop
	ori $8,$7,0x3366
	nop
	ori $9,$8,0xf111
	nop
	ori $10,$9,0x00ff
	
	#21
	jal label1
	ori $8,$ra,0x8899
	nop
	nop
label1:
	#22
	jal label2
	nop
	nop
	nop
	nop
label2:
	ori $9,$ra,0xaa12
	#23
	ori $t0,$0,35
	sw $ra,24($0)
	lw $t1,-11($t0)
	ori $t2,$t1,0xe2df
	
	#24
	sw $t2,36($0)
	lw $t3,1($t0)
	nop
	ori $t4,$t3,0xaabb
	
	