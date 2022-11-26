DIM = 8
.data
matrice: .byte 3, 1, 41, 5, 9, 26, 5, 35
.byte 89, 79, 32, 3, 8, 46, 26, 4
.byte 33, 8, 32, 79, 50, 28, 8, 4
.byte 19, 71, 69, 39, 9, 37, 5, 10
.byte 58, 20, 9, 74, 9, 44, 59, 2
.byte 30, 7, 8, 16, 40, 6, 28, 6
.byte 20, 8, 9, 98, 62, 80, 3, 48
.byte 25, 34, 21, 1, 70, 6, 7, 9
.text
.globl main
.ent main
main:

subu $sp, $sp, 4
sw $ra, ($sp)

la $a0, matrice
li $a1, 7
li $a2, DIM
jal maxInTriangolo

move $a0, $v0 # lettura del risultato calcolato dalla procedura
li $v0, 1
syscall

lw $ra, ($sp)
addiu $sp, $sp, 4
jr $ra
.end main

.ent maxInTriangolo

maxInTriangolo:

move $s0, $a0    # indirizzo matrice
move $s1, $a1    # indice di partenza
move $s2, $a2    # lato matrice

li $t0, -1    # MAX
add $t1, $s0, $s1    # indirizzo casella con vertice triangolo
add $t2, $s0, $s1    # indirizzo casella con offset per diagonale


loop:

lb $t3, 0($t1)
lb $t4, 0($t2)
addi $t2, $t2, -1

ble $t3, $t0, jump1
move $t0, $t3

jump1:
ble $t4, $t0, jump2
move $t0, $t4

jump2:
add $t1, $t1, $s2
add $t2, $t2, $s2

addi $s1, $s1, -1
bne $s1, $0, loop


loop_last_row:

lb $t3, 0($t2)
addi $t2, $t2, 1

ble $t3, $t0, jump3
move $t0, $t3

jump3:
bne $t2, $t1, loop_last_row


move $v0, $t0

jr $ra

.end maxInTriangolo