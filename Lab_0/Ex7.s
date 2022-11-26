.data
DIM = 5
wVett: .space 5*4
message_in: .asciiz "Insert 5 numbers:\n"
message_out: .asciiz "The minimum is:\n"
semicolon: .ascii ";"

	.text
	.globl main
	.ent main

main:

	la $t0, wVett
	li $t1, 0

	la $a0, message_in
	li $v0, 4
	syscall
	
# loop to get the integers from the user
r_loop: li $v0, 5
	syscall
	
	sw $v0, ($t0)
	addi $t0, 4
	addi $t1, 1

	blt $t1, DIM, r_loop
	
	
	
	# I assume the first num is the min and iterate on all the numbers to check
	la $t0, wVett
	li $t1, 1

	lw $t2, ($t0)
	
min_check_loop:	
	addi $t0, 4
	addi $t1, 1

	lw $t3, ($t0)
	bgt $t2, $t3, save_new_min
	blt $t1, DIM, min_check_loop
	j end


save_new_min:
	move $t2, $t3
	blt $t1, DIM, min_check_loop


end: 	la $a0, message_out
	li $v0, 4
	syscall

	move $a0, $t2
	li $v0, 1
	syscall

	# to print the final semicolon
	la $a0, semicolon
	li $v0, 4
	syscall

	li $v0, 10
	syscall
	
	.end main
