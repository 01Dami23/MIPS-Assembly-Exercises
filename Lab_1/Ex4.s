.data
	var: .word 0x3FFFFFF0

.text
.globl main
.ent main

main:
	lw $t1, var
	add $t1, $t1, $t1

	# I add 40 to $t1's value
	# addi $t2, $t1, 40
	# this operation generates an overflow error

	# we can try with the unsigned version (then we would 
	# need to check manually for overflow errors	
	addiu $t2, $t1, 40

	# and print the result
	move $a0, $t2
	li $v0, 1
	syscall

	# repeted instructions but saving 40 in $t2 in advance
	addi $t2, $0, 40
	# add $t2, $t1, $t2
	# this operation generates an overflow error

	# we can try the unsigned version
	addu $t2, $t1, $t2

	move $a0, $t2
	li $v0, 1
	syscall

	li $v0, 10
	syscall

.end main
