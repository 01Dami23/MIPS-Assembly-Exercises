.data
DIM = 4
message_in: .asciiz "Enter 5 numbers without spaces:\n"
message_out: .asciiz "Inserted numbers:\n"
spacer: .ascii "; "
alignment: .space 2	# without this wVett would start from the second half of a word, this way the program would crash
wVett: .space 20

	.text
	.globl main
	.ent main

main:

	# I print the message to the user
	la $a0, message_in
	li $v0, 4
	syscall


	la $t0, wVett	        # vector address
	li $t1, 0	        # counter


# loop to read the integers from the console
r_loop:	li $v0, 5
	syscall

	sw $v0, ($t0)
	add $t0, $t0, 4
	add $t1, $t1, 1

	blt $t1, 5, r_loop


	# I print the message to the user
	la $a0, message_out
	li $v0, 4
	syscall
	

	la $t0, wVett
	li $t1, 0


w_loop: lw $a0, ($t0)
	li $v0, 1
	syscall

	la $a0, spacer
	li $v0, 4
	syscall
	
	add $t0, $t0, 4
	add $t1, $t1, 1

	blt $t1, 5, w_loop

	
	li $v0, 10
	syscall

	.end main
