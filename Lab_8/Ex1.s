.data
	ora_in: .byte 12, 47
	ora_out: .byte 18, 14
	X: .byte 1
	Y: .byte 40

.text
.globl main
.ent main

main:
	subu $sp, $sp, 4
	sw $ra, 0($sp)

	la $a0, ora_in
	la $a1, ora_out
	lb $a2, X
	lb $a3, Y

	jal costoParcheggio

	move $a0, $v0
	li $v0, 1
	syscall

	lw $ra, 0($sp)
	addiu $sp, $sp, 4

	jr $ra

.end main


costoParcheggio:

	# RICORDA DI FARE LOAD BYTE lb DATO CHE SONO BYTE (NON LOAD WORD) !!!
	lb $t0, 0($a0) 	# hour in
	lb $t1, 0($a1) 	# hour out
	lb $t2, 1($a0) 	# minutes in RICORDA CHE SONO BYTE QUINDI SI VA AVANTI DI UNO ALLA VOLTA !!!
	lb $t3, 1($a1) 	# minutes out

	sub $t4, $t1, $t0 	# hours
	sub $t5, $t3, $t2 	# minutes

	li $t6, 60
	mul $t4, $t4, $t6 	# hours to minutes

	add $t4, $t4, $t5 	# tot minutes

	div $t4, $a3

	mflo $t4
	mfhi $t5
	beq $t5, $0, calculate_cost

	addi $t4, $t4, 1 

	calculate_cost:
		mul $t4, $t4, $a2

	move $v0, $t4

	jr $ra

.end costoParcheggio