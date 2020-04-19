# 150117855 Salih Özyurt
# 150115851 Enver ASLAN

				.data
input:   	  	.space 101
start:   	  	.asciiz "Enter an input string: "
palindrome:  	.asciiz " is palindrome."
notPalindrome:  .asciiz " is not palindrome."
newLine:	 	.asciiz "\n"
				.text
				.globl main
			
main:
	li $v0, 4                 # Print start
	la $a0, start
    syscall
	
	la $t0, input
	la $t1, input
	la $t7, newLine 
    lb $t7, 0($t7)
	
	li $v0, 8 			
    la $a0, input 		
    li $a1, 100 		
    syscall
	
	addu $s0, $0, 0		  	  # i = 0
	
strlen:	
	lb $t2, 0($t0)
	li $v0,11
	lb $a0, 0($t0)
	syscall
	
	la	$a0, newLine		  # Print \n
	li	$v0, 4
	syscall
	
	add $t0, $t0, 1
	
	beq $t2, $t7, strlenEnd
	
	addu $s0, $s0, 1		  	  # i += 1 
	
	j strlen
	
strlenEnd:
	sub $s0, $s0, 1
	la $t0, input
	
palindromeFunc:
	add $t1, $t1, $s0
	div $t4, $s0, 2
	addu $t5, $0, 0
	
	palindromeFuncLoop:
		lb $t2, 0($t0)
		lb $t3, 0($t1)
		
		li $v0,11
		lb $a0, 0($t0)
		syscall
	
		la	$a0, newLine		  # Print \n
		li	$v0, 4
		syscall
	
		li $v0,11
		lb $a0, 0($t1)
		syscall
	
		la	$a0, newLine		  # Print \n
		li	$v0, 4
		syscall
		
		bne $t2, $t3, notPalindromeEnd
		beq $t5, $t4, palindromeEnd
		
		add $t0, $t0, 1
		sub $t1, $t1, 1
		add $t5, $t5, 1
		
		j palindromeFuncLoop

palindromeEnd:
	la	$a0, input		  # Print \n
	li	$v0, 4
	syscall
	
	la	$a0, palindrome		  # Print \n
	li	$v0, 4
	syscall
	
	j end
notPalindromeEnd:
	la	$a0, input		  # Print \n
	li	$v0, 4
	syscall
	
	la	$a0, notPalindrome		  # Print \n
	li	$v0, 4
	syscall
	
	j end
end:
	li $v0, 10  			  # Finish the program
	syscall