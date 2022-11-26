.data 
	jumpTable: .word case_0, case_1, case_2, case_3
	opa: .word 2043
	opb: .word 5
	input_msg: .asciiz "Select an opetator: + -> 0, - -> 1, * -> 2, / -> 3: \n"
	output_msg: .ascii "The result is: "

.text
.globl main
.ent main

main:
	la $t0, jumpTable
	lw $t1, opa
	lw $t2, opb

	la $a0, input_msg
	li $v0, 4
	syscall

	# take operator from user input
	li $v0, 5
	syscall
	move $t3, $v0	# $t3 is the offset to apply to the address
	sll $t3, $t3, 2 # multiply the offset by 4 as we work with 4 bytes words

	add $t3, $t3, $t0
	lw $t0, ($t3)	# THIS IS HOW WE GET THE CONTENT OF $t3 AS AN ADDRESS

	jr $t0

case_0:
	add $t4, $t1, $t2
	j next

case_1:
	sub $t4, $t1, $t2
	j next

case_2:
	mul $t4, $t1, $t2
	j next

case_3:
	div $t4, $t1, $t2

next:
	la $a0, output_msg
	li $v0, 4
	syscall

	move $a0, $t4
	li $v0, 1
	syscall

	li $v0, 10
	syscall

.end main