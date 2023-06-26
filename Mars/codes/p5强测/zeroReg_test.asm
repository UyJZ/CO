.text
#addд0�Ĵ���
	ori $t0,$0,0xaabb
	add $0,$t0,$t0
	add $t1,$0,$t0
	
	add $0,$t1,$t0
	sub $t2,$t1,$0
	
	add $0,$t1,$t1
	ori $t3,$0,0xccdd
	
	add $0,$t2,$t2
	sw $t2,4($0)
	
	add $0,$t2,$t2
	lw $t4,4($0)
	
	add $0,$t2,$0
	beq $0,$t2,label1
label1:
	#���һ��ָ��
	ori $t0,$0,0x1122
	add $0,$t0,$t0
	nop
	add $t1,$0,$t0
	
	add $0,$t1,$t0
	nop
	sub $t2,$t1,$0
	
	add $0,$t1,$t1
	nop
	ori $t3,$0,0x3344
	
	add $0,$t2,$t2
	nop
	sw $t2,4($0)
	
	add $0,$t2,$t2
	nop
	lw $t4,4($0)
	
	add $0,$t2,$0
	nop
	beq $0,$t2,label1
	
	#�������ָ��
	ori $t0,$0,0x4321
	add $0,$t0,$t0
	nop
	nop
	add $t1,$0,$t0
	
	add $0,$t1,$t0
	nop
	nop
	sub $t2,$t1,$0
	
	add $0,$t1,$t1
	nop
	ori $t3,$0,0x0543
	
	add $0,$t2,$t2
	nop
	nop
	sw $t2,4($0)
	
	add $0,$t2,$t2
	nop
	nop
	lw $t4,4($0)
	
	add $0,$t2,$0
	nop
	nop
	beq $0,$t2,label1

# subд0�Ĵ���
	ori $t1,$0,0xaabb
	ori $t2,$0,0xccdd
	
	sub $0,$t2,$t1
	add $t3,$0,$0
	
	sub $0,$t2,$t1
	sub $t3,$t1,$0
	
	sub $0,$t2,$t1
	sub $t3,$0,$t1
	
	sub $0,$t2,$t1
	ori $t3,$0,0x1234
	
	sub $0,$t1,$t2
	sw $t1,16($0)
	
	sub $0,$t2,$t1
	lw $t4,16($0)
	
	sub $0,$t1,$0
	beq $t1,$0,label1
	
	sub $0,$t2,$0
	beq $0,$t2,label1
	
	#���1��ָ��
	ori $t1,$0,0xaabb
	ori $t2,$0,0xccdd
	
	sub $0,$t2,$t1
	nop
	add $t3,$0,$0
	
	sub $0,$t2,$t1
	nop
	sub $t3,$t1,$0
	
	sub $0,$t2,$t1
	nop
	sub $t3,$0,$t1
	
	sub $0,$t2,$t1
	nop
	ori $t3,$0,0x1234
	
	sub $0,$t1,$t2
	nop
	sw $t1,16($0)
	
	sub $0,$t2,$t1
	nop
	lw $t4,16($0)
	
	sub $0,$t1,$0
	nop
	beq $t1,$0,label1
	
	sub $0,$t2,$0
	nop
	beq $0,$t2,label1
	
	#�������ָ��
	ori $t1,$0,0xaabb
	ori $t2,$0,0xccdd
	
	sub $0,$t2,$t1
	nop
	nop
	add $t3,$0,$0
	
	sub $0,$t2,$t1
	nop
	nop
	sub $t3,$t1,$0
	
	sub $0,$t2,$t1
	nop
	nop
	sub $t3,$0,$t1
	
	sub $0,$t2,$t1
	nop
	nop
	ori $t3,$0,0x1234
	
	sub $0,$t1,$t2
	nop
	nop
	sw $t1,16($0)
	
	sub $0,$t2,$t1
	nop
	nop
	lw $t4,16($0)
	
	sub $0,$t1,$0
	nop
	nop
	beq $t1,$0,label1
	
	sub $0,$t2,$0
	nop
	nop
	beq $0,$t2,label1
	
# ori д0�Ĵ���
	ori $0,$t1,0xaabb
	add $t3,$0,$0
	
	ori $0,$t2,0xbbcc
	sub $t3,$t2,$0
	
	ori $0,$t2,0xddee
	sub $t3,$0,$t2
	
	ori $0,$t1,0x1234
	ori $t3,$0,0xaabb
	
	ori $0,$t2,0x1234
	sw $0,4($0)
	
	ori $0,$t2,0x3344
	sw $t2,0($0)
	
	ori $0,$t1,0x100
	lw $t3,0($0)
	
	ori $t1,$0,0xaabb
	ori $0,$0,0xaabb
	beq $0,$t1,label1
	
	ori $t1,$0,0xaabb
	ori $0,$0,0xaabb
	beq $t1,$0,label1
	
	#���һ��ָ��
	ori $0,$t1,0xaabb
	nop
	add $t3,$0,$0
	
	ori $0,$t2,0xbbcc
	nop
	sub $t3,$t2,$0
	
	ori $0,$t2,0xddee
	nop
	sub $t3,$0,$t2
	
	ori $0,$t1,0x1234
	nop
	ori $t3,$0,0xaabb
	
	ori $0,$t2,0x1234
	nop
	sw $0,4($0)
	
	ori $0,$t2,0x3344
	nop
	sw $t2,0($0)
	
	ori $0,$t1,0x100
	nop
	lw $t3,0($0)
	
	ori $t1,$0,0xaabb
	ori $0,$0,0xaabb
	nop
	beq $0,$t1,label1
	
	ori $t1,$0,0xaabb
	ori $0,$0,0xaabb
	nop
	beq $t1,$0,label1
	
	#�������ָ��
	ori $0,$t1,0xaabb
	nop
	nop
	add $t3,$0,$0
	
	ori $0,$t2,0xbbcc
	nop
	nop
	sub $t3,$t2,$0
	
	ori $0,$t2,0xddee
	nop
	nop
	sub $t3,$0,$t2
	
	ori $0,$t1,0x1234
	nop
	nop
	ori $t3,$0,0xaabb
	
	ori $0,$t2,0x1234
	nop
	nop
	sw $0,4($0)
	
	ori $0,$t2,0x3344
	nop
	nop
	sw $t2,0($0)
	
	ori $0,$t1,0x100
	nop
	nop
	lw $t3,0($0)
	
	ori $t1,$0,0xaabb
	ori $0,$0,0xaabb
	nop
	nop
	beq $0,$t1,label1
	
	ori $t1,$0,0xaabb
	ori $0,$0,0xaabb
	nop
	nop
	beq $t1,$0,label1
	nop