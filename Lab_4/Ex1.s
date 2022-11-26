.data
	DIM = 4 * 20
	wArray: .space DIM

.text
.globl main
.ent main

main:
	and $t0, $0, $0 	# counter for the loop

	# put first 2 values of the fibonacci sequence in the array
	li $t1, 1
	sw $t1, wArray($t0)

	addi $t0, $t0, 4

	li $t2, 1
	sw $t2, wArray($t0)

	addi $t0, $t0, 4

loop:
	# the 2 numbers of the array to compute the following one are in $t1 and $t2
	add $t3, $t1, $t2
	sw $t3, wArray($t0)
	move $t1, $t2
	move $t2, $t3

	addi $t0, $t0, 4
	blt $t0, DIM, loop

	li, $v0, 10
	syscall

.end main