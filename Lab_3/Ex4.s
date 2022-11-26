.data 
	DIM = 3
	input_msg: .asciiz "Enter 3 integers: \n"
	output_msg: .ascii "The average is: "

.text
.globl main
.ent main

main:

	la $a0, input_msg
	li $v0, 4
	syscall

	and $t0, $0, $0 	# loop counter
	and $t1, $0, $0 	# sum of input integers

# loop to read the 3 numbers
input_loop:
	li $v0, 5
	syscall
	add $t1, $t1, $v0

	addi $t0, $t0, 1

	bne $t0, DIM, input_loop

	# the result of division is a truncated integer
	div $t2, $t1, DIM

output:
	la $a0, output_msg
	li $v0, 4
	syscall

	move $a0, $t2
	li $v0, 1
	syscall

	li $v0, 10
	syscall

.end main