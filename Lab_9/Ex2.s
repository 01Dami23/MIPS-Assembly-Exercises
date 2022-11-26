.data
	str_orig: .asciiz "% nella citta' dolente, % nell'eterno dolore, % tra la perduta gente"
	str_sost: .asciiz "per me si va"
	str_new: .space 200

.text
.globl main
.ent main

main:
	subu $sp, $sp, 4
	sw $ra, 0($sp)
	
	la $a0, str_orig
	la $a1, str_sost
	la $a2, str_new

	jal sostituisci

	la $a0, str_new
	li $v0, 4
	syscall

	lw $ra, 0($sp)
	addu $sp, $sp, 4

	jr $ra

.end main


sostituisci:

	subu $sp, $sp, 4
	sw $a2, 0($sp)

	# faccio un for iterando sulla prima stringa 
		# cerco il carattere '%', se lo trovo chiamo la funzione per sostiturlo in str_new con str_sost

		# ad ogni iterazione salvo il carattere appena letto in str_new

	loop:
		move $t1, $a1

		lb $t0, 0($a0)

		# continuo fino a quando trovo il valore ASCII '0x00' ossia lo zero
		beq $t0, $0, end_loop

		# se il carattere = '%' aggiungo str_sost a str_new (all'indirizzo corrente di str_new)
		bne $t0, '%', copy

		substitute_loop:
			lb $t2, 0($t1)
			beq $t2, $0, decrement_a2

			sb $t2, 0($a2)

			addi $t1, $t1, 1
			addi $a2, $a2, 1

			j substitute_loop

		copy:
			sb $t0, 0($a2)
			j jump_decrement

		decrement_a2:
			sub $a2, $a2, 1

		jump_decrement:
			addi $a0, $a0, 1
			addi $a2, $a2, 1
			j loop


	end_loop:
		# calcolo la lunghezza della stringa in $a2
		lw $t1, 0($sp)
		addu $sp, $sp, 4

		sub $t2, $a2, 1
		sub $v0, $t2, $t1

		jr $ra

.end sostituisci