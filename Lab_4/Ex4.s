.data
	DIM = 10
	matrix: .space 4 * DIM * DIM

.text
.globl main
.ent main

main:

	# first row initialization
	li $t0, 0
init_loop_row:
	sll $t2, $t0, 2
	addi $t0, $t0, 1
	sw $t0, matrix($t2)
	blt $t0, DIM, init_loop_row

	# first column initialization
	li $t0, 0
init_loop_column:
	sll $t2, $t0, 2
	mul $t2, $t2, 10
	addi $t0, $t0, 1
	sw $t0, matrix($t2)
	blt $t0, DIM, init_loop_column


	addi $t0, $0, 1 	# counter loop_1

	la $t2, matrix

loop_1:

	add $t1, $0, $0 	# counter loop_2

	loop_2:
		
		sll $t3, $t0, 2
		mul $t3, $t3, 10
		sll $t4, $t1, 2

		
		# 1st element of current row
		add $t5, $t3, $t2
		lw $t5, ($t5)


		# 1st element of current column
		add $t6, $t4, $t2
		lw $t6, ($t6)

		# calculate offset of current cell in matrix
		add $t3, $t3, $t4

		# multiply 1st element of current row and 1st element of current column
		mul $t5, $t5, $t6

		# save the result in the current cell in matrix
		sw $t5, matrix($t3)

		addi $t1, $t1, 1
		blt $t1, DIM, loop_2
	# end loop_2

	addi $t0, $t0, 1
	blt $t0, DIM, loop_1
# end loop_1

	li $v0, 10
	syscall

.end main