#Q2 (40 points) Write and test a program that reads in a positive integer using the SPIM system calls. If the integer is 
#not positive, the program should terminate with the message ?Invalid Entry?; otherwise the program should print out
#the names of the digits of the integers, delimited by exactly one space. For example, if the user entered ?728,? the
#output would be ?Seven Two Eight.?
##  Original author:  Colt Darien 2/24/2014
##  Register usage:
##     

	.data
num_invalid: .asciiz "Invalid Entry"
num_zero: .asciiz "Zero "
num_one: .asciiz "One "
num_two: .asciiz "Two "
num_three: .asciiz "Three "
num_four: .asciiz "Four "
num_five: .asciiz "Five "
num_six: .asciiz "Six "
num_seven: .asciiz "Seven "
num_eight: .asciiz "Eight "
num_nine: .asciiz "Nine "

	.text
main:
	li      $v0, 5
	syscall
	move	$s0, $v0	#get the returned/read value
	bltz 	$s0, invalid
	li	$t1, 4		#4 is the end of transmission in ascii
	addi	$sp, $sp, -4	#move the stack down so that I can add the EOT
	sw	$t1, 0($sp)	#add it to the stack
	li	$t1, 10		#load $t1 with ten
get_num_loop:
	div	$s0, $t1	#the lowest digit will be in the $lo
	mflo	$s0		#this is the remaining numbers
	mfhi	$t0		#this is the least significant number left to convert
	beq 	$t0, 0, push_zero	#if this is the number then push that number so we can print it later
	beq 	$t0, 1, push_one	#if this is the number then push that number so we can print it later
	beq 	$t0, 2, push_two	#if this is the number then push that number so we can print it later
	beq 	$t0, 3, push_three	#if this is the number then push that number so we can print it later
	beq 	$t0, 4, push_four	#if this is the number then push that number so we can print it later
	beq 	$t0, 5, push_five	#if this is the number then push that number so we can print it later
	beq 	$t0, 6, push_six	#if this is the number then push that number so we can print it later
	beq 	$t0, 7, push_seven	#if this is the number then push that number so we can print it later
	beq 	$t0, 8, push_eight	#if this is the number then push that number so we can print it later	
	beq 	$t0, 9, push_nine	#if this is the number then push that number so we can print it later
conv_loop:
	beqz 	$s0, output_num	#this was the last cycle, print the number now
	b	get_num_loop	#that was not the last number so we need to go again

push_zero:
	addi	$sp, $sp, -4	#get the stack ready for a push
	la	$t2, num_zero	#get the address of the label and get ready to push
	sw	$t2, 0($sp)	#push the address of the text to the stack
	b conv_loop

push_one:
	addi	$sp, $sp, -4	#get the stack ready for a push
	la	$t2, num_one	#get the address of the label and get ready to push
	sw	$t2, 0($sp)	#push the address of the text to the stack
	b conv_loop
	
push_two:
	addi	$sp, $sp, -4	#get the stack ready for a push
	la	$t2, num_two	#get the address of the label and get ready to push
	sw	$t2, 0($sp)	#push the address of the text to the stack
	b conv_loop

push_three:
	addi	$sp, $sp, -4	#get the stack ready for a push
	la	$t2, num_three	#get the address of the label and get ready to push
	sw	$t2, 0($sp)	#push the address of the text to the stack
	b conv_loop
	
push_four:
	addi	$sp, $sp, -4	#get the stack ready for a push
	la	$t2, num_four	#get the address of the label and get ready to push
	sw	$t2, 0($sp)	#push the address of the text to the stack
	b conv_loop
	
push_five:
	addi	$sp, $sp, -4	#get the stack ready for a push
	la	$t2, num_five	#get the address of the label and get ready to push
	sw	$t2, 0($sp)	#push the address of the text to the stack
	b conv_loop
	
push_six:
	addi	$sp, $sp, -4	#get the stack ready for a push
	la	$t2, num_six	#get the address of the label and get ready to push
	sw	$t2, 0($sp)	#push the address of the text to the stack
	b conv_loop
	
push_seven:
	addi	$sp, $sp, -4	#get the stack ready for a push
	la	$t2, num_seven	#get the address of the label and get ready to push
	sw	$t2, 0($sp)	#push the address of the text to the stack
	b conv_loop
	
push_eight:
	addi	$sp, $sp, -4	#get the stack ready for a push
	la	$t2, num_eight	#get the address of the label and get ready to push
	sw	$t2, 0($sp)	#push the address of the text to the stack
	b conv_loop

push_nine:
	addi	$sp, $sp, -4	#get the stack ready for a push
	la	$t2, num_nine	#get the address of the label and get ready to push
	sw	$t2, 0($sp)	#push the address of the text to the stack
	b conv_loop

invalid:
	la	$a0, num_invalid # print the not-palindrome message
	li	$v0, 4
	syscall
	b	exit
output_num:
	lw 	$a0, 0($sp) 		# restore saved $s0
	beq	$a0, 4, exit	#if this is an end of transmission exit
	addi	$sp, $sp, 4	# move the stack back up so that we can get the next number
	#la	$a0, num_zero	# get the address of the first word to print
	li      $v0, 4		#otherwise print it
	syscall
	b	output_num
exit:
	li	$v0, 10
	syscall

# END OF PROGRAM
