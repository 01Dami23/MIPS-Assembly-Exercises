DIM = 6
.data
    vetB: .byte 2, 14, 119, 54, 10, 41
    vetN: .space DIM
.text
.globl main
.ent main

main: 

addu $sp, $sp, -4
sw $ra, 0($sp)

la $a0, vetB
la $a1, vetN
li $a2, DIM
jal Cambio

lw $ra, 0($sp)
addu $sp, $sp, 4

jr $ra

.end main


.ent Cambio

Cambio:

    # faccio un ciclo for su tutti gli elementi del vettore
    # TUTTO DA FARE IN LOGICA UNSIGNED

    # per ogni elemento del vettore conto i cambiamenti da 0 a 1 e viceversa
    # faccio un ciclo su tutti i 32 bit spostandomi ogni volta srl
        # prendo il risultato gia shiftato a dx di 1 e confronto 
        # i bit bassi dei 2 valori e ci faccio uno XOR
        # sommo il risultato dello XOR al valore corrente di cambiamenti
        # inizialmente inizializzato a 1

move $s0, $a0
move $s1, $a1
move $s2, $a2     # DIM

li $t0, 0         # contatore ciclo sul vettore
li $t9, 8

loop_vett:

li $t1, 0         # contatore ciclo sui singoli bit
li $t2, 0         # numero di cambi in un certo elemento

add $t8, $s0, $t0
lb $s3 0($t8)
srl $s4, $s3, 1

loop_bit:


andi $t3, $s3, 1
andi $t4, $s4, 1

xor $t5, $t3, $t4

add $t2, $t2, $t5

srl $s3, $s3, 1
srl $s4, $s4, 1

addi $t1, 1
blt $t1, $t9, loop_bit

add $t8, $s1, $t0
sb $t2, 0($s1)

move $a0, $t2
li $v0, 1
syscall

addi $t0, 1
blt $t0, $s2, loop_vett     

jr $ra     

.end Cambio