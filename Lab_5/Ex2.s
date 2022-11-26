.data
	input_msg: .asciiz "Enter a palindrome string: \n"
	output_msg_1: .asciiz "The string is a palindrome\n"
	output_msg_2: .ascii "The string is not a palindrome\n"
	

.text
.globl main
.ent main

main:
	la $a0, input_msg
	li $v0, 4
	syscall

	add $t0, $0, $0 	# counter of input characters
	li $t1, '\n'

# leggo carattere per carattere e salvo nello stack
read_loop:
	
	li $v0, 12
	syscall

	beq $v0, $t1, check

	addi $sp, $sp, -4
	sw $v0, 0($sp)

	addi $t0, $t0, 1

	j read_loop

check:
	
	# calcolo gli indici dei due estremi della stringa a cui accedere 
	# nello stack [$t2=0] e [$t3=($t1-1)*4]
	add $t2, $0, $0
	addi $t3, $t0, -1
	sll $t3, $t3, 2

	# calcolo il numero di iterazioni in cui controllare le coppie di valori 
	# dividendo per 2 il numero di valori
	srl $t0, $t0, 1

loop:
	add $sp, $sp, $t2
	lw $t4, 0($sp)
	sub $sp, $sp, $t2

	add $sp, $sp, $t3
	lw $t5, 0($sp)
	sub $sp, $sp, $t3

	addi $t0, $t0, -1
	addi $t2, $t2, 4
	addi $t3, $t3, -4

	bne $t4, $t5, wrong

	bgt $t0, $0, loop

	j right


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