.data
	space: .asciiz "\n"

.text
.globl main
.ent main

main:
	li $v0, 5
	syscall
	move $t1, $v0
	
	li $v0, 5
	syscall
	move $t2, $v0

	add $t1, $t1, $t2
	sub $t2, $t1, $t2
	sub $t1, $t1, $t2

	move $a0, $t1
	li $v0, 1
	syscall

	# go to next line
	la $a0, space
	li $v0, 4
	syscall

	move $a0, $t2
	li $v0, 1
	syscall

	li $v0, 10
	syscall

.end main
