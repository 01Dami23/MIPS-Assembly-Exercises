.data
	DIM = 5
	wVett: .word 3, 6, 2, 7, 1


.text
.globl main
.ent main

main:

	la $a0, wVett
	add $a1, $0, DIM

	jal massimo

	move $a0, $v0
	li $v0, 1
	syscall

	li $v0, 10
	syscall

.end main


massimo:

	lw $t0, 0($a0) 	# in $t0 sta il massimo
	addi $t2, $0, 4 # contatore
	sll $a1, $a1, 2

	search_max_loop:
		add $t3, $a0, $t2
		lw $t1, 0($t3)
		bge $t0, $t1, jump

		move $t0, $t1	# salva nuovo massimo

	jump:
		addi $t2, $t2, 4
		bne $t2, $a1, search_max_loop

	move $v0, $t0

	jr $ra
	
.end massimo