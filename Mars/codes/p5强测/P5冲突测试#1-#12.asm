.text
	ori $t1,$0,0xaabb
	ori $t3,$0,0xccff
	
	# 1
	add $t2,$t1,$t3
	add $t4,$t2,$t3
	sub $t5,$t4,$t1
	add $t6,$t5,$t3
	sub $t7,$t6,$t3
	sub $t8,$t7,$t1
	
	#2
	lui $t1,0xaadd
	lui $t2,0xccee
	
	add $t3,$t1,$t2
	add $t4,$t1,$t3
	sub $t5,$t3,$t4
	add $t6,$t2,$t5
	sub $t7,$t1,$t6
	sub $t8,$t2,$t7
	
	#3
	ori $s1,$0,0xaabb
	lui $s3,0xccdd
	ori $s3,$s3,0xeeff
	
	add $s2,$s1,$s3
	nop
	add $s4,$s2,$s3
	nop
	sub $s5,$s4,$s1
	nop
	add $s6,$s5,$s3
	nop
	sub $s7,$s6,$s3
	nop
	sub $s0,$s7,$s1
	nop
	
	#4
	lui $s1,0xaadd
	lui $s2,0xccee
	
	add $s3,$s1,$s2
	nop
	add $s4,$s1,$s3
	nop
	sub $s5,$s3,$s4
	nop
	add $s6,$s2,$s5
	nop
	sub $s7,$s1,$s6
	nop
	sub $s0,$s2,$s7
	nop
	
	#5
	ori $s0,$s1,0xddee
	add $s2,$s0,$s1
	lui $s3,0xffee
	add $s4,$s3,$s2
	ori $s5,$s2,0xffaa
	sub $s6,$s5,$s4
	lui $s6,0xddff
	sub $s7,$s6,$s0
	
	# 6
	ori $s0,$s1,0xddee
	add $s2,$s1,$s0
	lui $s3,0xffee
	add $s4,$s2,$s3
	ori $s5,$s2,0xffaa
	sub $s6,$s4,$s5
	lui $s6,0xddff
	sub $s7,$s0,$s6
	
	#7
	ori $t0,$t1,0xddee
	nop
	add $t2,$t0,$t1

	lui $t3,0xffee
	nop
	add $t4,$t3,$t2

	ori $t5,$t2,0xffaa
	nop
	sub $t6,$t5,$t4

	lui $t6,0xddff
	nop
	sub $t7,$t6,$t0
	
	# 8
	ori $t0,$t1,0xddee
	nop
	add $t2,$t1,$t0

	lui $t3,0xffee
	nop
	add $t4,$t2,$t3

	ori $t5,$t2,0xffaa
	nop
	sub $t6,$t4,$t5

	lui $t6,0xddff
	nop
	sub $t7,$t0,$t6
	
	# 9
	jal label1
	add $ra,$ra,$t7
	nop
	nop
	nop
label1:
	jal label2
	sub $t2,$ra,$t6
	nop
	nop
	nop
	nop
	
	#10
label2:
	jal label3
	add $ra,$t6,$ra
	nop
	nop
label3:
	jal label4
	sub $t3,$t4,$ra
	nop
	nop
	nop
label4:
	#11
	jal label5
	nop
	nop
	nop
label5:
	add $ra,$ra,$t7
	jal label6
	nop
	nop
	nop
	nop
	
label6:
	sub $t2,$ra,$t6
	#12	
	jal label7
	nop
	nop
label7:
	add $ra,$t6,$ra
	jal label8
	nop
	nop
	nop
label8:
	add $ra,$t6,$ra
	
	
	
	
	
	
	