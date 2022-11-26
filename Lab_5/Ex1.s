.data
	num: .word 3141592653

.text
.globl main
.ent main

main:

	# il main si salva il numero e lo passa come parametro facendo la prima chiamata alla funzione
	lw $a0, num

	jal print_num

	li $v0, 10
	syscall

.end main

# LE PROCEDURE LE FACCIO FUORI DAL MAIN E PER FARE UNA PROCEDURA MI BASTA METTERE "l'etichetta"
# ALL'INIZIO E IL ".end nomeProcedura" ALLA FINE CHE E' UTILE GRAFICAMENTE PER MOSTRARE CHE LA 
# PROCEDURA E' FINITA ED EVENTUALMENTE NELLE RIGHE SUCCESSIVE POSSO SCRIVERE ALTRE PROCEDURE

print_num:

	# salvo l'indirizzo di ritorno per quando torno indietro
	# OSS l'indirizzo di ritorno che mi salvo qui e' quello salvato in $ra dalla jal che ho 
	# chiamato nel primo caso nel main negli altri casi ricorsivamente nella funzione stessa

	addi $sp, $sp, -4
	sw $ra, 0($sp)

	li $t0, 10
	# OSS la divisione funziona tra registri non posso metterci un immediate
	divu $a0, $t0

	# quoziente della divisione
	mflo $t0
	# resto della divisione 
	mfhi $t1

	# salvo il resto della divisione nello stack per stamparlo quando torno indietro
	addi $sp, $sp, -4
	sw $t1, 0($sp)

	move $a0, $t0

	# se il quoziente e' diverso da zero continuo la ricorsione altrimenti torno indietro
	beq $t0, $0, finish

	jal print_num

	
finish:

	# stampo il resto prendendolo dallo stack
	lw $a0, 0($sp)
	addi $sp, $sp, 4

	# prima di stampare trasformo in ASCII
	addi $a0, $a0, 48

	li $v0, 11
	syscall

	# riprendo dallo stack l'indirizzo di ritorno a cui devo tornare per finire la funzione corrente
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra

.end print_num