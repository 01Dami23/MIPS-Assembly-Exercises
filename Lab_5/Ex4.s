.data
	DIM: .word 3
	matrix: .word 2, 0, 0
			.word 0, 0, 0
			.word 0, 0, 3

.text
.globl main
.ent main

main:

	la $t9, matrix

	add $t2, $0, $0 	# counter_1

	lw $t0, DIM
	addi $t1, $t0, 1
	li $t0, 4
	# i = 4 * (DIM+1)
	mul $t0, $t0, $t1
	mul $t0, $t0, $t2

	# j = 0
	add $t1, $0, $0 	# counter_2

	add $t8, $0, $0
	lw $t6, DIM
	lw $s3, DIM


loop:
	add $t4, $t0, $t1
	add $t4, $t4, $t9

	lw $s0, 0($t4)

	mul $t5, $t1, $s3
	add $t5, $t0, $t5
	add $t5, $t5, $t9

	lw $s1, 0($t5)

	bne $s0, $s1, not_symmetric

	# se non sono sulla diagonale e i due numeri sono diversi da zero 
	# mi segno $t8 = 1 e in fondo salto a 'symmetric' invece che stare
	# su 'diagonal'

	beq $t4, $t5, jump
	beq $s0, $0, jump

	addi $t8, $0, 1

jump:
	# aggiorno gli indici
	addi $t1, $t1, 4
	addi $t6, $t6, -1

	bne $t6, $0, loop
# -------------------------------------------

	addi $t2, $t2, 1

	# aggiorno i
	lw $t0, DIM
	addi $t1, $t0, 1
	li $t0, 4
	mul $t0, $t0, $t1
	mul $t0, $t0, $t2

	# aggiorno j
	add $t1, $0, $0

	lw $t6, DIM
	sub $t6, $t6, $t2

	bne $t6, $0, loop

	beq $t8, 1, symmetric

diagonal:
	li $a0, 2
	li $v0, 1
	syscall
	j end

symmetric:
	li $a0, 1
	li $v0, 1
	syscall
	j end
	
not_symmetric:
	li $a0, 0
	li $v0, 1
	syscall

end:
	li $v0, 10
	syscall

.end main