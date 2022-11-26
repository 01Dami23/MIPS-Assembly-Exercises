.data
var1: .byte 'm'
var2: .byte 'i'
var3: .byte 'p'
var4: .byte 's'
var5: .byte 0
a: .byte 'a'
A: .byte 'A'

	.text
	.globl main
	.ent main

main:
	li $t2, 0 	# counter
	la $t1, var1
	li $t3, 0
	lb $t4, a
	lb $t5, A
	sub $t3, $t5, $t4 
	# calculated how much to subtract in the ASCII
	# to get from a letter to its uppercase
	
loop:	# prendo la variabile
	# la faccio maiuscola(32 di shift in ascii, all'indietro)
	# la salvo in memoria
	# incremento il counter
	lb $t0, ($t1)
	
	add $t0, $t0, $t3

	sb $t0, ($t1)

	addi $t2, 1	# counter increment 
	addi $t1, 1	# memory increment (i move to the next var)

	bne $t2, 4, loop	


	# stampo la stringa
	la $a0, var1
	li $v0, 4
	syscall

	
	li $v0, 10
	syscall

	.end main
