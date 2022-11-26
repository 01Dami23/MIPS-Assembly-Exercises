.data
op1: .byte 150
op2: .byte 100

	.text
	.globl main
	.ent main

main:
	# if i interpret these 2 variables as signed, 
	# 150 doesn't fit in a byte and thus the result is 
	# incorrect, i must interpret them as unsigned numbers

	lbu $t0, op1
	lbu $t1, op2

	addu $t0, $t0, $t1
	
	move $a0, $t0
	li $v0, 1
	syscall

	li $v0, 10
	syscall

	.end main
