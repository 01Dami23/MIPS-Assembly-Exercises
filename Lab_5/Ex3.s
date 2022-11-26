.data
	input_msg: .asciiz "Enter 3 integers: \n"
	output_msg_1: .asciiz "The equation has real solutions\n"
	output_msg_2: .asciiz "The equation doesn't have real solutions\n"

.text
.globl main
.ent main

main:

	la $a0, input_msg
	li $v0, 4
	syscall
	
	# prendo i tre numeri in input (a, b, c)
	li $v0, 5
	syscall
	move $t0, $v0

	li $v0, 5
	syscall
	move $t1, $v0

	li $v0, 5
	syscall
	move $t2, $v0

	# delta: $t3
	mul $t1, $t1, $t1
	mul $t0, $t0, $t2
	li $t5, 4
	mul $t0, $t0, $t5

	sub $t3, $t1, $t0


	beq $t3, $0, right

	slt $t4, $0, $t3
	beq $t4, 1, right


wrong:
	la $a0, output_msg_2
	li $v0, 4
	syscall

	j end

right:
	la $a0, output_msg_1
	li $v0, 4
	syscall

end:
	li $v0, 10
	syscall

.end main