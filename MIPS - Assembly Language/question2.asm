#Sihle Calana - 08/10/20119
#question2.asm
#states whether a number is divisible by 2, by 3, by both or neither of the two numbers
#Registers used:
#	$t0	- used to hold the number
#	$t1	- used to hold mod 2
#	$t2	- used to hold mod 3
#	$t3	- used to hold loop counter
#	$t6	- used to hold 2
#	$t7	- used to hold 3

#Where the program data is stored
	.data
enter:	.asciiz "Enter a number:"
two:	.asciiz "It is divisible by 2\n"
three:	.asciiz "It is divisible by 3\n"
both:	.asciiz "It is divisible by both 2 and 3\n"
none:	.asciiz "It is neither divisible by 2 nor 3\n"

	.text
main:
	li $t3, 0
	li $t6, 2
	li $t7, 3 
	li $t4, 5 #value at which the loop should exit
	li $t5, 0 #if divisible then the remainder should be 0

loop:
	beq $t3, $t4, exit
	li $v0, 4
	la $a0, enter
	syscall
	li $v0, 5	#sets up the syscall for reading an integer	
	syscall		
	move $t0, $v0	#copies the inserted integer to register $t0
	rem $t1, $t0, $t6	#$t0 modulo 2 = $t1
	rem $t2, $t0, $t7		#$t0 modulo 3 = $t2
	bne $t1, $t5, test3	#if $t1 not 0
	bne $t2, $t5, print2	#if $t2 not 0
	la $a0, both
	li $v0, 4
	syscall
	addi $t3, $t3, 1
	j loop
	
print2:
	la $a0, two
	li $v0, 4
	syscall
	addi $t3, $t3, 1
	j loop

test3:
	bne $t2, $t5, neither	#if $t2 not 0
	la $a0, three
	li $v0, 4
	syscall
	addi $t3, $t3, 1
	j loop

neither:
	la $a0, none
	li $v0, 4
	syscall
	addi $t3, $t3, 1
	j loop

exit:
	li $v0, 10
	syscall