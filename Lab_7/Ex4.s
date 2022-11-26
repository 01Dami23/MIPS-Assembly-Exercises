.data
	matrix: .word 2, 8, 1, 3


.text
.globl main
.ent main

main:
	subu $sp, $sp, 4
	sw $ra, 0($sp)

	la $t0, matrix

	lw $a0, 0($t0)
	lw $a1, 4($t0)
	lw $a2, 8($t0)
	lw $a3, 12($t0)

	jal determinante2x2

	move $a0, $v0
	li $v0, 1
	syscall

	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	jr $ra

.end main


determinante2x2:
	mul $t0, $a0, $a3
	mul $t1, $a1, $a2
	sub $v0, $t0, $t1

	jr $ra

.end determinante2x2