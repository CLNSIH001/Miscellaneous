#Sihle Calana - 09/10/20119
#question3.asm
#states whether two numbers, received from the user, are relatively prime or not
#done using the mathematical Bezout's Lemma for finding the greatest common divisor
#Registers used:
#	$t0	- used to store the first number
#	$t1	- used to store the second number
#	$t2	- used to store 0
#	$t3	- used to store the remainder
#	$t4	- used to store 1

#Where the program data is stored
	.data
enter1:	.asciiz "Enter the first number:\n"
enter2:	.asciiz "Enter the second number:\n"
prime:	.asciiz "The two numbers are relatively prime"
nRP:	.asciiz "The two numbers are not relatively prime"

	.text
main:
	li $t2, 0
	li $t4, 1

	#get the first integer
	li $v0, 4
	la $a0, enter1
	syscall
	li $v0, 5	#sets up the syscall for reading an integer	
	syscall		
	move $t0, $v0	#copies the inserted integer to register $t0

	#get the second integer
	li $v0, 4
	la $a0, enter2
	syscall
	li $v0, 5	#sets up the syscall for reading an integer	
	syscall		
	move $t1, $v0	#copies the inserted integer to register $t0

	div $t0, $t1	#divides the first number by the second to get the quotient and remainder
	##mflo $t2	#copy the quotient to $t2
	mfhi $t3	#copy the remainder to $t3

loop:
	beq $t3, $t2, isPrime	#is the remainder 0
	move $t0, $t1
	move $t1, $t3
	div $t0, $t1
	##mflo $t2
	mfhi $t3
	j loop

isPrime:
	bne $t1, $t4, not_prime	#is the gcd = 1?
	la $a0, prime
	li $v0, 4
	syscall
	j exit

not_prime:
	la $a0, nRP
	li $v0, 4
	syscall
	j exit

exit:
	li $v0, 10
	syscall