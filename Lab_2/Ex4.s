.data
	hNum: .half 345

.text
.globl main
.ent main

main:
	# verify wether the right-most bit is a 1 or a 0 
	# with an AND between the number and 1
	# if the number is 1 increment the counter 

	# loop this until we checked all the numbers 
	# (16 as we work with a halfword)

	lh $t0, hNum
	# iterate 16 times 
	li $t1, 0	# counter of the loop
	li $t2, 0  	# counter of num of 1's in the binary of the number
	li $t3, 1	# value to compare the right/most bit in the AND

loop:   and $t4, $t0, $t3
	add $t2, $t2, $t4

	srl $t0, $t0, 1	# shift the num of one pos to the right
	add $t1, 1

	bne $t1, 15, loop

	move $a0, $t2
	li $v0, 1
	syscall

	li $v0, 10
	syscall

.end main
