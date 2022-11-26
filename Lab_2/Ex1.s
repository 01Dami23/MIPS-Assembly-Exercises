.data
	start_txt: .asciiz "Insert a positive integer:\n"
	even_txt: .asciiz "The number is even\n"
	odd_txt: .asciiz "The number is odd\n"

.text
.globl main
.ent main

main:
	la $a0, start_txt
	li $v0, 4
	syscall

	li $v0, 5
	syscall
	move $t0, $v0

	andi $t1, $t0, 1
	beq $t1, 1, odd

even:
	la $a0, even_txt
	li $v0, 4
	syscall
	j end

odd:
	la $a0, odd_txt
	li $v0, 4
	syscall

end:
	li $v0, 10
	syscall

.end main
