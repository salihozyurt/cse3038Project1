# 150117855 Salih Özyurt
# 150115851 Enver ASLAN

				.data
input:   	  	.space 101
start:   	  	.asciiz "Enter an input string: "
palindrome:  	.asciiz " is palindrome."
notPalindrome:  .asciiz " is not palindrome."
				.text
				.globl main
main:
	li $v0, 4                 # Print start
	la $a0, start
    syscall
	
    li $v0, 8				  # Read input
    li $a1, 100
    la $a0, input
    syscall

    li $v0, 4
    li $t0, 0				   # t0 = 0
	addu $t2, $0, 0		  	   # length = 0

lowercase:
    lb $t1, input($t0)		   # t1 = input[t0]
	beq $t1, 0, palindromeFunc # if t1 == '\0'
	beq $t1, 10, removeNewLine # if t1 == '\n'
    blt $t1, 65, increment	   # if t1 == 'A'
    bgt $t1, 90, increment	   # if t1 == 'Z'
    add $t1, $t1, 32		   # t1 += 32
    sb $t1, input($t0)		   # input[t0] = t1
	j lowercase			  	   # Go back to lowercase
	
	removeNewLine:
		sub $t1, $t1, 10	   # t1 -= 10 for null character
		sb $t1, input($t0)	   # input[t0] = t1
		addi $t0, $t0, 1	   # t0 += 1
		j lowercase			   # Go back to lowercase
		
	increment: 
		addi $t0, $t0, 1	   # t0 += 1
		add $t2, $t2, 1		   # length += 1
		j lowercase			   # Go back to lowercase

palindromeFunc:	
	li $t0, 0				   # t0 = 0
	add $t1, $t2, 0			   # t1 = length
	sub $t1, $t1, 1	   		   # t1 -= 1
	div $t2, $t2, 2			   # length = length / 2
	
	palindromeLoop:
		lb $t3, input($t0)		   # t3 = input[t0]
		lb $t4, input($t1)		   # t4 = input[length]
		
		bne $t3, $t4, notPalindromeEnd # if input[t0] != input[length]
		beq $t0, $t2, palindromeEnd	   # if t0 == length2
		
		add $t0, $t0, 1			# t0 += 1
		sub $t1, $t1, 1			# t0 -= 1
		
		j palindromeLoop

		palindromeEnd:
			la	$a0, input		  # Print input
			li	$v0, 4
			syscall
			
			la	$a0, palindrome	  # Print palindrome message
			li	$v0, 4
			syscall
			
			j end
			
		notPalindromeEnd:
			la	$a0, input		   # Print input
			li	$v0, 4
			syscall
			
			la	$a0, notPalindrome # Print notPalindrome message
			li	$v0, 4
			syscall
			
			j end

end:
    li $v0, 10
    syscall