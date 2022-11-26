N = 3
M = 4
.data
matriceA: 
    .word 0xAB317811, 0xCD514229, 0xEF832040, 0xA1346269
    .word 0xB2178309, 0xC3524578, 0x65702887, 0x59227465
    .word 0x14930352, 0x24157817, 0x39088169, 0x63245986
matriceB: 
    .word 0x39916800, 0x47900160, 0x62270208, 0x87178291
    .word 0xA7674368, 0xB2092278, 0xC3556874, 0xD6402373
    .word 0xE1216451, 0x24329020, 0x51090942, 0x11240007
matriceC: .space N * M * 4

.text
.globl main
.ent main

main: 

subu $sp, $sp, 4
sw $ra, ($sp)

la $a0, matriceA
la $a1, matriceB
la $a2, matriceC
li $a3, N

li $t0, M
subu $sp, $sp, 4
sw $t0, ($sp)

jal MediaMatrice

addiu $sp, $sp, 4
lw $ra, ($sp)
addiu $sp, $sp, 4
jr $ra

.end main


.ent MediaMatrice

MediaMatrice:

# scandisco tutte le celle con un singolo for che
# avanza di 4 posizioni alla volta l'indirizzo iniziale
# tramite un indice e di ferma quando l'indice = N*M*4

#....distinguo i due casi

# salvo la media nella casella di C

move $s0, $a0    # matrice A
move $s1, $a1    # matrice B
move $s2, $a2    # matrice C

move $s3, $a3    # N num righe
lw $s4, 0($sp)   # M num colonne

li $t0, 0    # indice da incrementare di 4
mul $t1, $s3, $s4    # N*M
sll $t1, $t1, 2      # N*M*4

loop:

add $t7, $t0, $s0
add $t8, $t0, $s1
add $t9, $t0, $s2

lw $t2, 0($t7)
lw $t3, 0($t8)

# verifico se i due elementi hanno stesso segno o segni opposti
slt $t4, $t2, $0    # se <0 mi da 0 se >= 0 mi da 1
slt $t5, $t3, $0

beq $t4, $t5, same_sign
add $t2, $t2, $t3
li $t3, 2
div $t2, $t3
mflo $t2

j end

same_sign:

addu $t2, $t2, $t3
li $t3, 2
divu $t2, $t3
mflo $t2

beq $t4, $0, negativi
# altrimenti sono positivi
sll $t2, $t2, 1
srl $t2, $t2, 1

negativi:
lui $t6, 0x8000               # 1000.0000-0000.0000
ori $t6, $t6, 0x0000

or $t2, $t2, $t6

end:

sw $t2, 0($t9)

addi $t0, $t0, 4
blt $t0, $t1, loop

jr $ra

.end MediaMatrice