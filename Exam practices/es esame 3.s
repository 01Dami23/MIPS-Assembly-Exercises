.ent SpaceRemove

SpaceRemove:

# prendo i due indirizzi dei due vettori

# prendo i primi due elementi di vetRX e li salvo
# scambiati in vetTX

# ciclo aumentando l'indirizzo di vetRX di 1 alla volta (lavorando con byte)
# prendo il valore da vetRX
    # se il val = 0x20 salto al prossimo valore
    # se il val <> 0x20 lo salvo in vetTX e incremento l'indirizzo di vetTX

move $s0, $a0    # indirizzo vetRX
move $s1, $a1    # indirizzo vetTX

lb $t0, 0($s0)
addi $s0, $s0, 1

lb $t1, 0($s0)
addi $s0, $s0, 1

sb $t1, 0($s1)
addi $s1, $s1, 1

sb $t0, 0($s1)
addi $s1, $s1, 1

li $t4, 0x20
li $t5, 0x03

loop:

lb $t0, 0($s0)
addi $s0, $s0, 1

beq $t0, $t5, end
beq $t0, $t4, loop

# qui metto in vetTX
sb $t0, 0($s1)
addi $s1, $s1, 1

j loop

end:

sb $t5, 0($s1)

jr $ra

.end SpaceRemove