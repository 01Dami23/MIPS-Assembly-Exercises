.data
wVett: .word 5, 7, 3, 4
wResult: .space 4

	.text
	.globl main
	.ent main

main:	
	
	la $t0, wVett  	# I save the address of the vector 
	       	        # and increment it at each sum

	and $t1, $0, $0 # I initialize to 0 the register 
			# I will use to compute the sum

	# I sum every number in the vector and update the address in $t0
	lw $t2, ($t0)
	addi $t0, 4
	add $t1, $t1, $t2

	
	lw $t2, ($t0)
	addi $t0, 4
	add $t1, $t1, $t2

	
	lw $t2, ($t0)
	addi $t0, 4
	add $t1, $t1, $t2


	lw $t2, ($t0)
	add $t1, $t1, $t2


	li $v0, 10
	syscall

	.end main
