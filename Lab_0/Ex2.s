.data
wVar: .word 3

	.text
	.globl main
	.ent main

main:
	
	li $t0, 10	# I save an immediate in $t0
	sw $t0, wVar	# I store the previously saved value in wVar in memory


	li $v0, 10
	syscall
	
	.end main