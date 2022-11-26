.ent CalcoloCF

CalcoloCF:

addu $sp, $sp, -4
sw $ra, 0($sp)

move $s0, $a0    # cognome
move $s1, $a1    # nome 
move $s2, $a2    # data
move $s3, $a3    # stringa da riempire

move $t9, $s3

# prendo le prime 3 consonanti dal cognome ciclando 
# su tutta la stringa di cognome 

li $t0, 0    # contatore delle lettere prese

# COGNOME
loop:
beq $t0, 3, end_surname

lb $t1, 0($s0)
addi $s0, $s0, 1

blt $t1, 'B', loop
bgt $t1, 'Z', loop
beq $t1, 'E', loop
beq $t1, 'I', loop
beq $t1, 'O', loop
beq $t1, 'U', loop

sb $t1, 0($t9)
addi $t9, $t9, 1
addi $t0, $t0, 1
j loop

end_surname:
# NOME
li $t0, 0

loop2:
beq $t0, 3, end_name

lb $t1, 0($s1)
addi $s1, $s1, 1

blt $t1, 'B', loop2
bgt $t1, 'Z', loop2
beq $t1, 'E', loop2
beq $t1, 'I', loop2
beq $t1, 'O', loop2
beq $t1, 'U', loop2

sb $t1, 0($t9)
addi $t9, $t9, 1
addi $t0, $t0, 1
j loop2


end_name:

# metto in $a0, il mese con i due caratteri in 0x...

jal MonthToChar

# prendo da $v0, il risultato della procedura

lw $ra, 0($sp)
addu $sp, $sp, 4
jr $ra

.end CalcoloCF