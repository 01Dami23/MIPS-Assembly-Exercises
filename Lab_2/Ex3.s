.data
	var1: .word 0x0FA00101
	var2: .word 0x00FF0D45
	var3: .word 0x00009623
	space: .ascii "   "

.text
.globl main
.ent main

main:
	lw $t0, var1
	lw $t1, var2
	lw $t2, var3
	la $t4, space

	bgt $t0, $t1, swap1
	j second

swap1:	move $t3, $t0
	move $t0, $t1
	move $t1, $t3

second:	bgt $t0, $t2, swap2
	j third

swap2:	move $t3, $t0
	move $t0, $t2
	move $t2, $t3

third:  bgt $t1, $t2, swap3
	j end

swap3:	move $t3, $t1
	move $t1, $t2
	move $t2, $t3

	move $a0, $t0
	li $v0, 1
	syscall

	la $a0, space
	li $v0, 4
	syscall

	move $a0, $t1
	li $v0, 1
	syscall

	la $a0, space
	li $v0, 4
	syscall
	
	move $a0, $t2
	li $v0, 1
	syscall

end:	li $v0, 10
	syscall

.end main
