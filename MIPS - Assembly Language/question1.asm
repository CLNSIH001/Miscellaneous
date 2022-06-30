#question1.asm
#lists factors (between 1 and 10) of a number inserted by the user
# $t0 is the number that serves as a counter or factor
# $t1 is the number inserted by the user
# $t3 is the remainder after dividing $t1 by $t0

.data
enter:		.asciiz "Enter a number:\n"
divresults:	.asciiz "The single digit divisors are:\n"
newLine:	.asciiz "\n"

	.text
main:
	li $t0, 2	#loads counter/factor starting at 2
	li $t4, 0	#0register
	li $t2, 10	#max size of counter
	li $v0, 4
	la $a0, enter
	syscall
	li $v0, 5	#sets up the syscall for reading an integer	
	syscall		
	move $t1, $v0	#copies the inserted integer to register $t1
	la $a0, divresults
	li $v0, 4
	syscall

loop:
	beq $t0, $t2, exit
	rem $t3, $t1, $t0
	bne $t3, $t4, else
	move $a0, $t0
	li $v0, 1
	syscall
	la $a0, newLine
	li $v0, 4
	syscall
	addi $t0, $t0, 1
	j loop

else:
	addi $t0, $t0, 1
	j loop

exit:
	li $v0, 10
	syscall