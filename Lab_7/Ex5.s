.data
	matrix: .word 1, 8, 5, 9, 6, 3, 4, 7, 2

.text
.globl main
.ent main

main:
	subu $sp, $sp, 4
	sw $ra, 0($sp)

	la $t0, matrix
	addi $t1, $0, 5 	# loop counter

	lw $a0, 0($t0)
	lw $a1, 4($t0)
	lw $a2, 8($t0)
	lw $a3, 12($t0)

	addi $t0, $t0, 16

	# loop per salvare i 5 parametri restanti nello stack
	save_loop:
		lw $t2, 0($t0)

		# salvo nello stack
		subu $sp, $sp, 4
		sw $t2, 0($sp)

		addi $t0, $t0, 4
		addi $t1, $t1, -1
		bne $t1, $0, save_loop
	
	jal determinante3x3

	move $a0, $v0
	li $v0, 1
	syscall

	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	jr $ra

.end main


determinante3x3:
	# PRIMA DI SALVARE COSE NELLO STACK MI PRENDO I PARAMETRI
	# PASSATI DAL MAIN TRAMITE STACK
	lw $t8, 0($sp)
	lw $t7, 4($sp)
	lw $t6, 8($sp)
	lw $t5, 12($sp)
	lw $t4, 16($sp)
	addiu $sp, $sp, 20

	move $t0, $a0
	move $t1, $a1
	move $t2, $a2
	move $t3, $a3

	# salvo il return address per quando devo tornare al main
	subu $sp, $sp, 4
	sw $ra, 0($sp)

	# ---------------------------------------------------------
	move $a0, $t4
	move $a1, $t5
	move $a2, $t7
	move $a3, $t8

	# salvo nello stack i CALLER-SAVE register per non perderne 
	# il contenuto con la chiamata a funzione
	subu $sp, $sp, 8
	sw $t0, 4($sp)
	sw $t1, 0($sp)

	jal determinante2x2

	lw $t1, 0($sp)
	lw $t0, 4($sp)
	addiu $sp, $sp, 8

	move $s0, $v0
	mul $s0, $t0, $s0
	# ---------------------------------------------------------

	# ---------------------------------------------------------
	move $a0, $t3
	move $a1, $t5
	move $a2, $t6
	move $a3, $t8

	# salvo nello stack i CALLER-SAVE register per non perderne 
	# il contenuto con la chiamata a funzione
	subu $sp, $sp, 8
	sw $t0, 4($sp)
	sw $t1, 0($sp)

	jal determinante2x2

	lw $t1, 0($sp)
	lw $t0, 4($sp)
	addiu $sp, $sp, 8

	move $s1, $v0
	mul $s1, $t1, $s1
	# ---------------------------------------------------------

	# ---------------------------------------------------------
	move $a0, $t3
	move $a1, $t4
	move $a2, $t6
	move $a3, $t7

	# salvo nello stack i CALLER-SAVE register per non perderne 
	# il contenuto con la chiamata a funzione
	subu $sp, $sp, 8
	sw $t0, 4($sp)
	sw $t1, 0($sp)

	jal determinante2x2

	lw $t1, 0($sp)
	lw $t0, 4($sp)
	addiu $sp, $sp, 8

	move $s2, $v0
	mul $s2, $t2, $s2
	# ---------------------------------------------------------

	# calcolo il risultato finale
	sub $v0, $s0, $s1
	add $v0, $v0, $s2

	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	jr $ra

.end determinante3x3


determinante2x2:
	mul $t0, $a0, $a3
	mul $t1, $a1, $a2
	sub $v0, $t0, $t1

	jr $ra

.end determinante2x2