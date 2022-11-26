.data
	input_text: .asciiz "Enter single character integers:\n"
	error_text: .asciiz "\nWrong input\n"
	end_text: .asciiz "The input is correct\n"
	no_num: .asciiz "No integers were inserted"

.text
.globl main
.ent main

main:
	and $t1, $0, $0	# counter of inserted integers

	la $a0, input_text
	li $v0, 4
	syscall
	
loop:	
	li $v0, 12
	syscall
	
	beq $v0, '\n', end_msg
	blt $v0, '0', error_msg
	bgt $v0, '9', error_msg

	addi $t1, $t1, 1	# increment counter
	j loop

error_msg:
	la $a0, error_text
	j print_msg

end_msg:	
	beq $t1, 0, noNum
	la $a0, end_text
	j print_msg

noNum:
	la $a0, no_num

print_msg:
	li $v0, 4
	syscall

end:
	li $v0, 10
	syscall

.end main
