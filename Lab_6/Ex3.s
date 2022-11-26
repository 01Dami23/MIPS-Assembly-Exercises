.data
	wordVett: .space 32
	input_msg: .asciiz "Insert a word:\n"

.text
.globl main
.ent main

main:

	la $a0, input_msg
	li $v0, 4
	syscall

	la $s0, wordVett
	add $s1, $0, $0 	# counter of char num
	add $s2, $0, $0

	input_loop:
		li $v0, 12
		syscall

		beq $v0, '\n', output_loop

		move $a0, $v0
		jal minToMaiusc

		add $t2, $s0, $s1
		sb $v0, 0($t2)

		addi $s1, $s1, 1

		j input_loop

	output_loop:
		add $t1, $s0, $s2

		lb $a0, 0($t1)
		li $v0, 11
		syscall

		addi $s2, $s2, 1
		addi $s1, $s1, -1
		bne $s1, $0, output_loop


	li $v0, 10
	syscall

.end main


# riceve un carattere tramite $a0, e lo rende maiuscolo 
# (assumendo di ricevere sempre caratteri minuscoli)
minToMaiusc:

	move $t0, $a0
	addi $t0, $t0, -32
	move $v0, $t0

	jr $ra

.end minToMaiusc