 .data
wVett: .word 10, 2, 4, 5, 8
wResult: .space 4

	.text
	.globl main
	.ent main

main:
	
	la $t0, wVett
	add $t1, $0, $0
	add $t3, $0, $0		# I initialize the counter to 0

loop:	lw $t2, ($t0)		# I create the loop
	addi $t0, 4
	add $t1, $t1, $t2
	addi $t3, 1		# I do the increment on the counter

	ble $t3, 4, loop

        sw $t1, wResult

	li $v0, 10
	syscall
	
	.end main
