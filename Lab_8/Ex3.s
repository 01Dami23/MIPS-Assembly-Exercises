.data
	prezzi: .word 10, 15, 34, 26, 5
	prezzi_scontati: .space 4*5
	lunghezza: .word 5
	sconto: .word 20 	# 20%
	arrotondamento: .word 1

.text
.globl main
.ent main

main:
	
	subu $sp, $sp, 4
	sw $ra, 0($sp)

	la $s0, prezzi
	la $s1, prezzi_scontati
	lw $s2, lunghezza
	lw $s3, sconto
	lw $s4, arrotondamento

	move $a0, $s0
	move $a1, $s1
	move $a2, $s2
	move $a3, $s3

	subu $sp, $sp, 4
	sw $s4, 0($sp)

	jal calcola_sconto

	add $t0, $0, $0
	print_loop:

		# --------------------
		sll $t1, $t0, 2
		add $t1, $t1, $s0

		lw $a0, 0($t1)
		li $v0, 1
		syscall
		# --------------------

		li $a0, 32	# spazio
		li $v0, 11
		syscall

		li $a0, 45	# -
		li $v0, 11
		syscall

		li $a0, 62 	# >
		li $v0, 11
		syscall

		li $a0, 32 	# spazio
		li $v0, 11
		syscall

		# --------------------
		sll $t1, $t0, 2
		add $t1, $t1, $s1

		lw $a0, 0($t1)
		li $v0, 1
		syscall
		# --------------------

		li $a0, 10 	# \n
		li $v0, 11
		syscall

		addi $t0, $t0, 1
		bne $t0, $s2, print_loop

	lw $ra, 0($sp)
	addiu $sp, $sp, 4

	jr $ra

.end main


calcola_sconto:

	# prendo il quinto parametro dallo stack
	lw $t4, 0($sp) 	# arrotondamento
	addiu $sp, $sp, 4

	move $t0, $a0 	# indirizzo corrente vett prezzi
	move $t1, $a1	# indirizzo corrente vett prezzi_scontati
	move $t2, $a2   # lunghezza
	move $t3, $a3	# sconto percentuale

	add $t5, $0, $0 	# counter * 1

	loop:

		lw $t6, 0($t0) 	# prezzo corrente
		li $t7, 100
		sub $t8, $t7, $t3 	# 80

		mul $t6, $t6, $t8
		div $t6, $t7

		mflo $t6

		li $t7, 1
		bne $t4, $t7, jump_1

		mfhi $t7
		li $t8, 50
		blt $t7, $t8, jump_1

		addi $t6, $t6, 1

		jump_1:

			sw $t6, 0($t1)

			addi $t0, $t0, 4
			addi $t1, $t1, 4
			addi $t5, $t5, 1

			bne $t5, $t2, loop

	jr $ra

.end calcola_sconto