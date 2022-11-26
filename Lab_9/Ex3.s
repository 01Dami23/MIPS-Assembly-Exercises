RIGHE = 4
COLONNE = 5
.data
	matrice: .byte 0, 1, 3, 6, 2, 7, 13, 20, 12, 21, 11, 22, 10, 23, 9, 24, 8, 25, 43, 62

.text
.globl main
.ent main

main:
	subu $sp, $sp, 4
	sw $ra, 0($sp)

	la $a0, matrice
	li $a1, 12
	li $a2, RIGHE 		# NR
	li $a3, COLONNE 	# NC

	jal contaVicini

	move $a0, $v0
	li $v0, 1
	syscall

	lw $ra, 0($sp)
	addu $sp, $sp, 4

	jr $ra

.end main


contaVicini:

	move $t0, $a1 	# val
	li $t1, 0 		# somma totale
	li $t2, 1 		# somma_sopra
	li $t3, 1 		# somma_sotto
	li $t4, 1 		# somma_sx
	li $t5, 1 		# somma_dx

		blt $t0, $0, jump_1
		bge $t0, $a3, jump_1

		li $t2, 0

	jump_1:
		sub $t6, $a2, 1
		mul $t6, $t6, $a3
		blt $t0, $t6, jump_2

		mul $t6, $a2, $a3
		bge $t0, $t6, jump_2

		li $t3, 0

	jump_2:
		div $t0, $a3
		mfhi $t6
		bne $t6, $0, jump_3

		li $t4, 0

	jump_3:
		addi $t6, $t0, 1
		div $t6, $a3
		mfhi $t6
		bne $t6, $0, jump_4

		li $t5, 0
# --------------------------------------------
	jump_4:
		beq $t2, $0, jump_5
		beq $t4, $0, jump_5

		sub $t6, $t0, 1
		sub $t6, $t6, $a3

 		# sommo all'indirizzo iniziale della matrice
		add $t6, $a0, $t6
		lb $t6, 0($t6)

		add $t1, $t1, $t6

	jump_5:
		beq $t2, $0, jump_6

		sub $t6, $t0, $a3

 		# sommo all'indirizzo iniziale della matrice
		add $t6, $a0, $t6
		lb $t6, 0($t6)

		add $t1, $t1, $t6

	jump_6:
		beq $t2, $0, jump_7
		beq $t5, $0, jump_7

		addi $t6, $t0, 1
		sub $t6, $t6, $a3

 		# sommo all'indirizzo iniziale della matrice
		add $t6, $a0, $t6
		lb $t6, 0($t6)

		add $t1, $t1, $t6

	jump_7:
		beq $t4, $0, jump_8

		sub $t6, $t0, 1

 		# sommo all'indirizzo iniziale della matrice
		add $t6, $a0, $t6
		lb $t6, 0($t6)

		add $t1, $t1, $t6

	jump_8:
		beq $t5, $0, jump_9

		addi $t6, $t0, 1

 		# sommo all'indirizzo iniziale della matrice
		add $t6, $a0, $t6
		lb $t6, 0($t6)

		add $t1, $t1, $t6

	jump_9:
		beq $t3, $0, jump_10
		beq $t4, $0, jump_10

		sub $t6, $t0, 1
		add $t6, $t6, $a3

 		# sommo all'indirizzo iniziale della matrice
		add $t6, $a0, $t6
		lb $t6, 0($t6)

		add $t1, $t1, $t6

	jump_10:
		beq $t3, $0, jump_11

		add $t6, $t0, $a3

 		# sommo all'indirizzo iniziale della matrice
		add $t6, $a0, $t6
		lb $t6, 0($t6)

		add $t1, $t1, $t6

	jump_11:
		beq $t3, $0, jump_end
		beq $t5, $0, jump_end

		addi $t6, $t0, 1
		add $t6, $t6, $a3

 		# sommo all'indirizzo iniziale della matrice
		add $t6, $a0, $t6
		lb $t6, 0($t6)

		add $t1, $t1, $t6

	jump_end:
		move $v0, $t1
		jr $ra

.end contaVicini