.data
	anni: .word 1945, 2008, 1800, 2006, 1748, 1600
	risultato: .byte 0, 0, 0, 0, 0, 0
	lunghezza: .word 6


.text
.globl main
.ent main

main:
	subu $sp, $sp, 4
	sw $ra, 0($sp)

	la $s0, anni
	la $s1, risultato
	lw $s2, lunghezza

	move $a0, $s0
	move $a1, $s1
	move $a2, $s2

	jal bisestile

	move $t0, $s1
	move $t1, $s2
	add $t2, $0, $0 	# counter
	loop:

		lb $a0, 0($t0)
		li $v0, 1
		syscall

		li $a0, 32
		li $v0, 11
		syscall

		addi $t0, $t0, 1
		addi $t2, $t2, 1
		bne $t2, $t1, loop

	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	jr $ra

.end main


bisestile:

	move $t0, $a0
	move $t1, $a1
	move $t2, $a2

	add $t3, $0, $0 	# counter vett word (+4)
	add $t4, $0, $0 	# counter vett byte (+1)

	loop_bisestile:

		add $t5, $t0, $t3
		lw $t5, 0($t5)

		li $t6, 100
		div $t5, $t6

		mfhi $t6
		bne $t6, $0, jump_1

		li $t6, 400
		div $t5, $t6

		mfhi $t6
		bne $t6, $0, end_loop

		add $t6, $t1, $t4
		li $t7, 1
		sb $t7, 0($t6)

		j end_loop


		jump_1:

			li $t6, 4
			div $t5, $t6

			mfhi $t6
			bne $t6, $0, end_loop

			add $t6, $t1, $t4
			li $t7, 1
			sb $t7, 0($t6)


		end_loop:

			addi $t3, $t3, 4
			addi $t4, $t4, 1

			bne $t4, $t2, loop_bisestile

	jr $ra		

.end bisestile