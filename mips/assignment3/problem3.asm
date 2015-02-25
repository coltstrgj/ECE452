#Q3 (50 points) Write and test a MIPS assembly language program to compute and print the first 100 prime
#numbers. A number n is prime if no numbers except 1 and n divide it evenly. You should implement two routines:
#- test_prime (n) Return 1 if n is prime and 0 if n is not prime.
#- main () Iterate over the integers, testing if each is prime. Print the first 100 numbers that are prime. Test
#your programs by running them on SPIM.
##  Original author:  Colt Darien 2/24/2014
##  
##  I will push the numbers to the stack because ther is no reason to check divisibility by all numbers
## when checking if divisible by all previous primes will prove if it is prime or not   

	.data
prime_store: 	.space 1024	#leave a big gap to store them all
newline:	.asciiz "\n"

	.text
	li	$s0, 0		#$s0 will save the number of primes we have found
	li	$s1, 1		#$s2 will be the number we are trying to check for prime
main:	
	beq	$s0, 400, exit	#400 for the 100 words of 4 bytes
	addi	$s1, $s1, 1	#add one to the int we are checking(so that we can check the next int)
	add	$a0, $s1, $zero	#fill arg one with the number we are checking
	jal	test_prime	#jump to test_prime
	bgtz 	$v0, prime	#branch if true rather than branch if false (to save a few cycles)
	b	not_prime
		
prime:	#we found a prime, so add it to the list, and inc $s0
	sw	$s1, prime_store($s0)	#put the number into storage
	addi	$s0, $s0, 4	#incriment the number of primes we have so far(by four for the word offset)
	add	$a0, $s1, $zero	# arg0 should have the prime
	li	$v0, 1		#the syscall code for print_int
	syscall
	la	$a0, newline	# print a newline so that the numbers dont all run together
	li      $v0, 4
	syscall
	b	main
not_prime:#this is not a prime, increment and try again.
	b	main
	
	
###############################################################################
test_prime: #get an arg in $a0  and return truth value of $a0==prime in $v0
	li	$t0, 0	#this will keep track of the offset for the prim_store
check_loop:
	lw	$t1, prime_store($t0)	#fetch the value of the prime number (offset by $t0)
	beqz	$t1, return_true	#this is the last value(a 0 means that nothing is stored here yet) so the number is prime
	div	$a0, $t1		#check if the arg is divisible by the current prime number
	mfhi	$t2			#store the remainder in $t2
	beqz 	$t2, return_false	#if the remainder is 0 this is not a prime (it is divisible by something)
	addi	$t0, $t0, 4		#4 is the word offset
	b	check_loop
return_false:
	li	$v0, 0			#we are returning a 0
	b	end_check_loop
return_true:
	li	$v0, 1			#we are returning a 1
	b	end_check_loop
end_check_loop:
	jr	$ra			#return to the caller

exit:
	li	$v0, 10
	syscall

# END OF PROGRAM
