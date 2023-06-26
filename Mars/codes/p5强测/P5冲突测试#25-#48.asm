.text
	lui $t1,0xaabb
	ori $t2,0xccdd
	#25
	add $t3,$t1,$t2
	add $t4,$t2,$t1
	beq $t3,$t4,label1 #��ת
	ori $t8,$t3,0xaabb
	nop
label2:
	nop
label3:
	sub $t3,$t9,$t1
	beq $t4,$t3,label1   #����ת
	#27
	add $s1,$t8,$t9
	add $s2,$s1,$0
	nop
	beq $s2,$s1,label4	#��ת
	sub $s6,$t8,$t9
label1:
	sub $t3,$t2,$t1
	beq $t3,$t4,label2 #����ת
	#26
	add $t3,$t1,$t2
	beq $t4,$t3,label3 #��ת
	lui $t9,0xaabb
label4:
	sub $s2,$s6,$s1
	beq $s2,$s1,label2  #����ת
	#28
	add $t1,$t8,$t9
	sub $t2,$t1,$0
	nop
	beq $t2,$t1,label5 #��ת
	nop
label6:
	sub $t2,$t1,$0
	nop
	nop
	beq $t2,$t1,label7  #��ת
	#30
	ori $s1,$0,0xffff
label5:
	#29
	add $t3,$t1,$t2
	add $t4,$t1,$t2
	nop
	nop
	beq $t3,$t4,label6 #��ת
	lui $t1,0xbbdd
	nop
	nop
label7:
	add $s2,$s1,$s1
	sub $s3,$s2,$s1
	nop
	beq $s1,$s2,label8 #����ת 
	beq $s1,$s3,label8 #��ת
	nop
	nop
label8:
	#31
	ori $t1,$s1,0xffea
	ori $t2,$s3,0xffea
	beq $t2,$t1,label9 #��ת
	lui $t2,0xffff
	nop
label10:
	lui $t6,0xddee
	lui $t6,0xddff
	beq $t5,$t6,label11 #����ת
	lui $t6,0xddee
	beq $t5,$t6,label11 #��ת
	#33
	ori $t7,$0,0xdefd
label9:
	beq $t2,$t1,label8 #����ת
	#32
	ori $t3,$0,0xaaee
	ori $t4,$0,0xaaee
	beq $t3,$t4,label10 #��ת
	lui $t5,0xddee
label11:
	ori $t8,$0,0xdefd
	nop
	beq $t8,$t7,label12 #��ת
	lui $t8,0xdefa
	nop
	nop
label12:
	nop
	beq $t8,$t7,label9 #����ת
	# 34
	ori $1,$t8,0xaabb
	ori $2,$t8,0xaabb
	nop
	beq $1,$2,label13 #��ת
	lui $5,0xddaa
label13:
	lui $6,0xddaa
	nop
	beq $5,$6,label14 #��ת
	nop
label15:
	# 36
	ori $2,$1,0xaabb
	nop
	nop
	beq $1,$2,label13 #����ת
	
	# 37��38����
	#39
	jal label16
	add $30,$31,$0
label14:
	# 35
	lui $1,0x1234
	lui $2,0x1234
	nop
	beq $1,$2,label15 #��ת
	nop
label17:
	#40
	jal label18
	sub $29,$31,$0
label16:
	beq $31,$30,label17 #��ת
	nop
label18:
	beq $29,$31,label19 #��ת
	nop
	nop
label19:
	# 41
	jal label20
	sw $ra,12($0)
	nop
label20:
	lw $1,12($0)
	beq $ra,$1,label21 #��ת
	ori $1,$0,9
label22:
	lw $2,-5($1)
	beq $2,$ra,label23 #��ת
	nop
label21:
	# 42
	jal label22
	sw $ra,4($0)
label24:
	# 46
	sw $8,0($0)
	lw $10,-9($1)
	nop
	beq $8,$10,label25	#��ת
	nop
label23:
	# 43, 44�Ѿ������
	# 45
	lw $8,12($0)
	lw $9,3($1)
	beq $8,$9,label24 #��ת
	nop
label25:
	# 47
	lw $28,0($0)
	lw $29,0($0)
	nop
	nop
	beq $29,$28,label26 #��ת
	add $30,$29,$28
	nop
label26:
	# 48
	sw $30,4($0)
	lw $29,4($0)
	nop
	nop
	beq $28,$29,label25  #����ת
	nop
	
	
	
	
	
	
	
	
	
	
	