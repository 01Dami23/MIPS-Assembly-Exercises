.data
	n: .word 6
	k: .word 3


.text
.globl main
.ent main

main:
	lw $a0, n
	lw $a1, k

	jal combina

	move $a0, $v0
	li $v0, 1
	syscall


	li $v0, 10
	syscall

.end main


combina:
	# $t0 = n-k+1
	sub $t0, $a0, $a1
	add $t0, $t0, 1

	move $t1, $a0	# $t1 = n
	move $t2, $a1 	# $t2 = k

	move $t3, $t1

	# ciclo per calcolare il numeratore in $t3
	num_loop:
		addi $t1, $t1, -1
		mul $t3, $t3, $t1

		bgt $t1, $t0, num_loop


	move $t4, $t2

	# ciclo per calcolare il denominatore in $t4
	den_loop:
		addi $t2, $t2, -1
		mul $t4, $t4, $t2

		bgt $t2, 1, den_loop

	# divisione tra numeratore e denominatore in $v0
	div $v0, $t3, $t4

	jr $ra

.end combina