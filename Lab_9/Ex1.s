DIM = 3
DIM_RIGA = DIM * 4

.data
	mat1: .word 4, -45, 15565,    6458, 4531, 124,    -548, 2124, 31000
	mat2: .word 6, -5421, -547,    -99, 4531, 1456,    4592, 118, 31999
	indice: .word 2
	vet_out: .space DIM_RIGA

.text
.globl main
.ent main

main:
	subu $sp, $sp, 4
	sw $ra, 0($sp)

	la $a0, mat1
	la $a1, mat2
	la $a2, vet_out
	li $a3, DIM

	subu $sp, $sp, 4
	lw $t0, indice
	sw $t0, 0($sp)

	jal proceduraVariazione

	addu $sp, $sp, 4

	# stampo i risultati
	li $t0, 0
	li $t1, DIM_RIGA

	la $t2, vet_out

	print_loop:

		lw $a0, 0($t2)
		li $v0, 1
		syscall

		li $a0, 32
		li $v0, 11
		syscall

		addi $t0, $t0, 4
		addi $t2, $t2, 4
		bne $t0, $t1, print_loop

	lw $ra, 0($sp)
	addu $sp, $sp, 4

	jr $ra

.end main


proceduraVariazione:

	# salvo il $fp nello stack per avere il riferimento fisso allo $sp 
	# quando prendo i parametri passati alla funzione tramite stack
	subu $sp, $sp, 4
	sw $fp, 0($sp)

	move $fp, $sp

	subu $sp, $sp, 8
	sw $s0, 4($sp)
	sw $s1, 8($sp)

	lw $t0, 4($fp) 		# indice

	# prima del for calcolo gli indirizzi di inizio: mat1: $s0 = $a0 + DIM_RIGA * indice
    # 												 mat2: $s1 = $a1 + 4 * indice
    li $t1, DIM_RIGA
    mul $s0, $t0, $t1
    add $s0, $a0, $s0
    li $t2, 4
    mul $s1, $t0, $t2
    add $s1, $a1, $s1

    li $t3, 0  	# contatore


	# faccio un for per DIM volte in cui itero aumentando di 4 l'indirizzo di mat1 
	# e aumentando di 4*DIM l'indirizzo di mat2
    loop:

    	# calcolo la variazione percentuale
    	lw $t4, 0($s0)
    	lw $t5, 0($s1)

    	sub $t5, $t5, $t4
    	li $t6, 100
    	mul $t5, $t5, $t6
    	div $t5, $t5, $t4

    	# salvo il risultato in vet_out
    	add $t7, $a2, $t3
    	sw $t5, 0($t7)

    	# incremento gli indirizzi di mat1 e mat2
    	addi $s0, $s0, 4
    	add $s1, $s1, $t1
    	addi $t3, $t3, 4
    	bne $t3, $t1, loop

    lw $s0, 0($sp)
    lw $s1, 4($sp)
    lw $fp, 8($sp)
    addu $sp, $sp, 12

   	jr $ra

.end proceduraVariazione