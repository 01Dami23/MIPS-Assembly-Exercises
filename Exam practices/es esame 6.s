.data
	stringa1: .asciiz "0alcolatori Elettronici 2019/2020\n"
	stringa2: .asciiz "ALTO o basso?\n"

.text
.globl main
.ent main

main:
	subu $sp, $sp, 4
	sw $ra, ($sp)

	la $a0, stringa1
	la $a1, stringa2

	jal cercaSequenza

	move $a0, $v0
	li $v0, 1
	syscall

	lw $ra, ($sp)
	addiu $sp, $sp, 4

	jr $ra

.end main


.ent cercaSequenza

cercaSequenza:

	move $s1, $a0
	move $s2, $a1

	# faccio un for su tutte le lettere della stringa2 fino a quando finisce
	# e cioe si trova il carattere terminatore 0

	# per ogni lettera faccio un for che avanza sulla stringa1 fino a 
	# quando trovo match o fino a quando finisce la stringa

	# se trovo match incremento il counter di 1

	# salvo in $v0 il counter


	li $t0, 0    # counter

	loop_str_2:

	lb $t2, 0($s2)
	addi $s2, $s2, 1

	blt $t2, 'A', jump1
	bgt $t2, 'Z', jump1
	addi $t2, $t2, 32

	jump1:

	beq $t2, $0, end

	loop_str_1:

	lb $t1, 0($s1)
	addi $s1, $s1, 1

	beq $t1, $0, end

	blt $t1, 'A', jump2
	bgt $t1, 'Z', jump2
	addi $t1, $t1, 32

	jump2:

	bne $t2, $t1, loop_str_1


	addi $t0, $t0, 1

	j loop_str_2


end:

move $v0, $t0
jr $ra

.end cercaSequenza