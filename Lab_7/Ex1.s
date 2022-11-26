.data
	N: .word 5

.text
.globl main
.ent main

main:
	subu $sp, $sp, 4
	sw $ra, 0($sp)

	li $t0, 4
	li $t1, 2
	li $t2, -5
	li $t3, 3

	li $s0, 8
	li $s1, 4
	li $s2, 27
	li $s3, 9
	li $s4, 64
	li $s5, 16

	# inizializzazione $a0
	add $a0, $t0, $t1
	add $a0, $a0, $t2
	add $a0, $a0, $t3

	# inizializzazione $a1
	mul $t4, $t0, $s0
	mul $t5, $t1, $s1
	li $t6, 2
	mul $t6, $t2, $t6

	add $a1, $t4, $t5
	add $a1, $a1, $t6
	add $a1, $a1, $t3

	# inizializzazione $a2
	mul $t4, $t0, $s2
	mul $t5, $t1, $s3
	li $t6, 3
	mul $t6, $t2, $t6

	add $a2, $t4, $t5
	add $a2, $a2, $t6
	add $a2, $a2, $t3

	# inizializzazione $a3
	mul $t4, $t0, $s4
	mul $t5, $t1, $s5
	li $t6, 4
	mul $t6, $t2, $t6

	add $a3, $t4, $t5
	add $a3, $a3, $t6
	add $a3, $a3, $t3


	# salva i registri temporanei CALLER-SAVE prima di chiamare la procedura
	subu $sp, $sp, 16
	sw $t0, 12($sp)
	sw $t1, 8($sp)
	sw $t2, 4($sp)
	sw $t3, 0($sp)

	# ---------------------------------------------------------------

	# passagio quinto parametro N tramite stack
	lw $t8, N
	subu $sp, $sp, 4
	sw $t8, 0($sp)

	# chiamata alla procedura
	jal polinomio

	# ripristrina i registri temporanei CALLER-SAVE dopo aver chiamato la procedura
	lw $t3, 0($sp)
	lw $t2, 4($sp)
	lw $t1, 8($sp)
	lw $t0, 12($sp)
	addiu $sp, $sp, 16

	# ---------------------------------------------------------------

	move $a0, $v0
	li $v0, 1
	syscall

	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	jr $ra

.end main


polinomio:
	# salvataggio quinto parametro preso da stack
	lw $t4, 0($sp)
	addiu $sp, $sp, 4

	# SALVO SOLO I REGISTRI CALLEE-SAVE DI CUI CAMBIO IL VALORE NELLA FUNZIONE
	# salva i registri CALLEE-SAVE prima di alterarli nella procedura
	subu $sp, $sp, 12
	sw $s0, 8($sp)
	sw $s1, 4($sp)
	sw $s2, 0($sp)

	# ---------------------------------------------------------------

	sub $t0, $a1, $a0
	sub $t1, $a2, $a1
	sub $t2, $a3, $a2
	sub $s0, $t1, $t0
	sub $s1, $t2, $t1
	sub $s2, $s1, $s0
	move $v0, $a3

	addi $t4, $t4, -4	# loop counter

	loop:
		add $s1, $s1, $s2
		add $t2, $t2, $s1
		add $v0, $v0, $t2

		addi $t4, $t4, -1
		bne $t4, $0, loop

	# ripristina i registri CALLEE-SAVE prima di tornare nel main
	lw $s2, 0($sp)
	lw $s1, 4($sp)
	lw $s0, 8($sp)
	addiu $sp, $sp, 12

	# ---------------------------------------------------------------

	jr $ra

.end polinomio