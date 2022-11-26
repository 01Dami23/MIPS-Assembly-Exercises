.data
	input_msg: .asciiz "Enter an integer:\n"
	output_msg: .asciiz "The next integer is:\n"

.text
.globl main
.ent main

main:
	subu $sp, $sp, 4
	sw $ra, 0($sp)

	la $a0, input_msg
	li $v0, 4
	syscall

	li $v0, 5
	syscall

	move $a0, $v0

	jal calcolaSuccessivo

	# salvo il risultato per non perderlo
	move $s0, $v0

	la $a0, output_msg
	li $v0, 4
	syscall

	move $a0, $s0
	li $v0, 1
	syscall

	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	jr $ra

.end main


calcolaSuccessivo:

	move $t0, $a0
	li $t1, 2

	# se la divisione per 2 da resto nullo ho un num 
	# pari altrimenti dispari
	div $t0, $t1

	mfhi $t2
	beq $t2, $0, pari

	dispari:
		li $t2, 3
		mul $t3, $t0, $t2
		addi $v0, $t3, 1

		j endFunction

	pari:
		mflo $v0

	endFunction:
		jr $ra

.end calcolaSuccessivo