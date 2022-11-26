DIM = 5

.data
	vet1: .word 56, 12, 98, 129, 58
	vet2: .word 1, 0, 245, 129, 12
	risultato: .space DIM

.text
.globl main
.ent main

main:
	subu $sp, $sp, 4
	sw $ra, 0($sp)

	la $a0, vet1
	la $a1, vet2
	la $a2, risultato
	li $a3, DIM

	jal calcolaDistanzaH

	add $t0, $0, $0
	move $t1, $a3
	print_loop:

		add $t2, $t0, $a2

		lb $a0, 0($t2)
		li $v0, 1
		syscall

		li $a0, 32
		li $v0, 11
		syscall

		addi $t0, $t0, 1
		bne $t0, $t1, print_loop

	lw $ra, 0($sp)
	addiu $sp, $sp, 4

	jr $ra

.end main


calcolaDistanzaH:

	move $t0, $a0
	move $t1, $a1
	move $t2, $a2
	move $t3, $a3

	add $t4, $0, $0
	add $v0, $0, $0

	loop:
		
		lw $t5, 0($t0)
		lw $t6, 0($t1)

		xor $t7, $t5, $t6

		add $t9, $0, $0

		loop_interno: 	 # per contare gli 1

			li $t8, 2
			div $t7, $t8

			mfhi $t8
			mflo $t7

			beq $t8, $0, end_loop_interno

			addi $t9, $t9, 1

			end_loop_interno:
				bne $t7, $0, loop_interno

		sb $t9, 0($t2)

		addi $t0, $t0, 4
		addi $t1, $t1, 4
		addi $t2, $t2, 1
		addi $t4, $t4, 1
		bne $t4, $t3, loop
	
	jr $ra

.end calcolaDistanzaH