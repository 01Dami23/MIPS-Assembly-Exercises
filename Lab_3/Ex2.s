.data
	input_text: .asciiz "Enter single character integers:\n"
	error_text: .asciiz "\nWrong input\n"
	end_text: .asciiz "The input is correct\n"
	no_num_text: .asciiz "No integers were inserted"
	overflow_text: .asciiz "Overflow error\n"

.text
.globl main
.ent main

main:
	and $t1, $0, $0	# counter of inserted integers
	and $t2, $0, $0 # "ACCUMULATORE"

	la $a0, input_text
	li $v0, 4
	syscall
	
loop:	
	li $v0, 12
	syscall
	
	# transform the last read char into an integer
	move $t0, $v0
	sub $t0, $t0, '0'	# 1
	multu $t2, 10		# 2
	addu $t2, $t2, $t0	# 3

	# check for oevrflow
	mfhi $t3
	bne $t3, $0, overflow_msg
	
	beq $v0, '\n', end_msg
	blt $v0, '0', error_msg
	bgt $v0, '9', error_msg

	addi $t1, $t1, 1	# increment counter
	j loop

error_msg:
	# print number
	move $a0, $t2
	li $v0, 1
	syscall

	la $a0, error_text
	j print_msg

end_msg:	
	beq $t1, 0, noNum
	la $a0, end_text
	j print_msg

oevrflow_msg:
	la $a0, overflow_text
	j print_msg

noNum:
	la $a0, no_num_text

print_msg:
	li $v0, 4
	syscall

end:
	li $v0, 10
	syscall

.end main
