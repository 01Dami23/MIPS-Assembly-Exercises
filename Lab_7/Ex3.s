.data
	input_msg: .asciiz "Enter an integer:\n"
	output_msg: .asciiz "The number of loops is:\n"

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

	jal sequenzaDiCollatz

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


sequenzaDiCollatz:
	# salvo $ra per poter tornare al main essendo una procedura non-leaf
	subu $sp, $sp, 4
	sw $ra, 0($sp)

	move $s0, $a0 		# integer su cui fare la procedura
	addi $s1, $0, 1 	# counter
	li $s2, 1

	loop:
		addi $s1, $s1, 1

		move $a0, $s0

		jal calcolaSuccessivo

		move $s0, $v0

		bne $s0, $s2, loop

	move $v0, $s1

	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	jr $ra

.end sequenzaDiCollatz


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