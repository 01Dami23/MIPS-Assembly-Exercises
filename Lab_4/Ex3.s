.data
	DIM = 4
	column: .word 3, 7, 4, 5
	row: .word 1, 3, 5, 2
	matrix: .space 4 * 4 * DIM

.text
.globl main
.ent main

main:
	add $t0, $0, $0 	# counter loop_1
	add $t1, $0, $0 	# counter loop_2

	la $t2, column
	la $t3, row
	la $t4, matrix

loop_1:
	
	add $t1, $0, $0 	# counter loop_2 reset for every outer loop we start

	loop_2:
		# prendo l'elemento della colonna
		sll $t5, $t0, 2
		add $t5, $t5, $t2
		lw $t5, ($t5)
	
		# prendo l'elemento della riga
		sll $t6, $t1, 2
		add $t6, $t6, $t3
		lw $t6, ($t6)

		sll $t7, $t0, 4
		sll $t8, $t1, 2
		add $t7, $t7, $t8
		add $t7, $t7, $t4

		mul $t5, $t5, $t6
		sw $t5, ($t7)
	
		addi $t1, $t1, 1
		blt $t1, DIM, loop_2
	# loop_2 end

	addi $t0, $t0, 1
	blt $t0, DIM, loop_1
# loop_1 end


	li $v0, 10
	syscall

.end main