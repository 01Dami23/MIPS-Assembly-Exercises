.data
	DIM = 8

.text
.globl main
.ent main

main:

	jal stampaTriangolo

	jal stampaQuadrato
	
	li $v0, 10
	syscall

.end main


# Procedura per stampare il triangolo isoscele
stampaTriangolo:

	li $t2, '*'
	li $t3, '\n'
	addi $t0, $0, 1
	addi $t1, $0, 1

	loop:

		addi $t1, $0, 1

		print_loop:

			move $a0, $t2
			li $v0, 11
			syscall

			addi $t1, $t1, 1
			ble $t1, $t0, print_loop

		move $a0, $t3
		li $v0, 11
		syscall

		addi $t0, $t0, 1
		ble $t0, DIM, loop

	jr $ra

.end stampaTriangolo


# Procedura per stmpare il quadrato
stampaQuadrato:
	li $t2, '*'
	li $t3, '\n'
	addi $t0, $0, 1
	addi $t1, $0, 1

	loop_2:

		addi $t1, $0, 1

		print_loop_2:

			move $a0, $t2
			li $v0, 11
			syscall

			addi $t1, $t1, 1
			ble $t1, DIM, print_loop_2

		move $a0, $t3
		li $v0, 11
		syscall

		addi $t0, $t0, 1
		ble $t0, DIM, loop_2

	jr $ra

.end stampaQuadrato