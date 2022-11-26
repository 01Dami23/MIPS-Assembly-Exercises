.data
	ROWS = 3*4*5
	COLUMNS = 5*4
	table: .word 154, 123, 109, 86, 4, 0, 412, -23, -231, 9, 50, 0, 123, -24, 12, 55, -45, 0, 0, 0, 0, 0, 0, 0

.text
.globl main
.ent main

main:

	# 5x3 table:
	la $t0, table

	add $t1, $0, $0 	# row/column counter

# compute rows sum
rows_loop:

	add $t2, $0, $0 	# cell counter 
	add $t3, $0, $0 	# row sum

	row_sum_loop:

		add $t4, $t1, $t2
		add $t4, $t4, $t0
		lw $t4, ($t4)
		add $t3, $t3, $t4
	
		addi $t2, $t2, 4
		blt $t2, COLUMNS, row_sum_loop

		# save sum
		add $t4, $t1, $t2
		sw $t3, table($t4)
	# end row_cells_loop

	addi $t1, $t1, 24	# 4 * 6
	blt $t1, ROWS, rows_loop
# end rows_loop


add $t1, $0, $0 	# row/column counter


# compute columns sum
columns_loop:

	add $t2, $0, $0 	# cell counter 
	add $t3, $0, $0 	# column sum

	column_sum_loop:

		add $t4, $t1, $t2
		add $t4, $t4, $t0
		lw $t4, ($t4)
		add $t3, $t3, $t4
	
		addi $t2, $t2, 24 	# 4 * 6
		blt $t2, ROWS, column_sum_loop

		# save sum
		add $t4, $t1, $t2
		sw $t3, table($t4)
	# end column_sum_loop

	addi $t1, $t1, 4
	blt $t1, COLUMNS, columns_loop
# end columns_loop

	li $v0, 10
	syscall

.end main