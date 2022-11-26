.data
	start_txt: .asciiz "Enter 2 positive integers:\n"
	error_txt: .asciiz "Error\n"

.text
.globl main
.ent main

main:
	la $a0 start_txt
	li $v0, 4
	syscall

	li $v0, 5
	syscall
	move $t0, $v0
	
	li $v0, 5
	syscall
	move $t1, $v0

	# if number < 256 it fits in a byte as an unsigned value
	bge $t0, 256, error
	bge $t1, 256, error
	
	not $t3, $t1
	and $t3, $t0, $t3
	not $t3, $t3
	xor $t0, $t0, $t1
	or $t0, $t3, $t0

	andi $t0, 0x000000FF
	move $a0, $t0
	li $v0, 1
	syscall

	j end

error:
	la $a0, error_txt
	li $v0, 4
	syscall

end :
	li $v0, 10
	syscall	

.end main
