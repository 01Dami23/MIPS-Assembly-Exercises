# in a byte we can't have more than 255 as a number
# so the max number of minutes will be: 255*24*60 + 
# + 255*60 + 255 = 382755 which fits in a .word variable 
# without overflow as in 4 bytes = 32 bits we can fit up 
# to 2147483647 for positive numbers as we work in ca2

.data 
	result: .space 4
	days: .byte 10
	hours: .byte 13
	minutes: .byte 26

.text
.globl main
.ent main

main:

# we can use lbu to extend the number that fits in a byte 
# from 127 to 255, as with two's complements 127 is the 
# maximum number that fits in a byte

	lbu $t0, days
	mul $t0, $t0, 24
	mul $t0, $t0, 60

	lbu $t1, hours
	mul $t1, $t1, 60

	lbu $t2, minutes

	addu $t3, $t0, $t1
	addu $t3, $t3, $t2

	sw $t3, result

	li $v0, 10
	syscall

.end main