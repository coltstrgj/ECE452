#   Adder
##  Original author:  Colt Darien 2/24/2014
##  Register usage:
##     $s1     - The running sum
##     $t3     - character at address A
##     $t4     - integer representation of the ascii input
##     $v0     - syscall parameter / return value
##     $a0     - syscall parameters
##     $a1     - syscall parameters

	.data
string_space:       .space 1024
sum_msg:  .asciiz "The sum is: "

	.text
main:
        ## read the character string into string_space
	la      $a0, string_space
	li      $a1, 1024
	li      $v0, 8
	syscall ##the above is "stolen" from your palendrome example
	
	addi    $t1, $zero, 10		# set the character to check for as a new line
	la      $t2, string_space	# start upper pointer at beginning
	addi	$t4, $zero, 0		# reset the value of t4
	
length_loop: #this converts the input to integer from ascii because I could not find a read integer sys call (I know there is one, I just could not find it)
	lb      $t3, ($t2)		# grab the character at upper ptr	
	beq	$t3, $t1, end_length_loop	# if $t3 == 0, we're at the terminator
	mul	$t4, $t4, 10		# shift the existing digits in $t4 to the left (because they are a power of ten higher than the number we just read)
	subi    $t3, $t3, 48		# convert it to an integer instead of ascii
	add	$t4, $t4, $t3		# $t3 only stores the latest number we have read so add it to the rest of the overall number
	addi	$t2, $t2, 1		# move to the next character pointer
	b       length_loop		# repeat the loop
end_length_loop:
	beqz	$t4, show_sum		# if the input was a 0 then we show the sum(that was the last input the user wanted to enter)
	add	$s1, $t4, $s1		# otherwise $t4 has the integer input so we add it to the sum
	b	main			# branch back to get the next number
show_sum:
	la	$a0, sum_msg	# print "The sum is: "
	li      $v0, 4
	syscall
	add	$a0, $s1, $zero	# arg0 should have the answer
	li	$v0, 1		#the syscall code for print_int
	syscall
	b	exit

exit:
	li	$v0, 10
	syscall

# END OF PROGRAM
