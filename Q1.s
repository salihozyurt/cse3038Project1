# 150117855 Salih Özyurt
# 150115851 Enver ASLAN

             .data 
start:   	 .asciiz "Enter the number of iteration for the series: "
resultTitle: .asciiz "Iteration		a	b	a^2-2b^2	a/b\n------------------------------------------------------\n"
space:		 .asciiz "	"
newLine:	 .asciiz "\n"
             .text
             .globl main
			
main:
	li $v0, 4                 # Print start
	la $a0, start
    syscall

	li $v0, 5                 # Get iteration count
	syscall
	
	addu $t1, $v0, $0		  # Count of iteration
	addi $t1, $t1, 1		  # Count of iteration + 1
	addu $t0, $0, 1		      # iteration = 1
	
	addu $s0, $0, 1		  	  # a = 1
	addu $s1, $0, 1		  	  # b = 1

	li $v0, 4                 # Print resultTitle
	la $a0, resultTitle
    syscall
	
calculateAndPrint:
	li $v0, 1                 # Print iteration
	add $a0, $t0, $0
    syscall

	addi $t0, $t0, 1		  # iteration = iteration + 1

	la	$a0, space			  # Print space
	li	$v0, 4
	syscall
	
	la	$a0, space			  # Print space
	li	$v0, 4
	syscall
	
	li $v0, 1                 # Print iteration
	add $a0, $s0, $0
    syscall
	
	la	$a0, space			  # Print space
	li	$v0, 4
	syscall
	
	li $v0, 1                 # Print iteration
	add $a0, $s1, $0
    syscall
	
	la	$a0, space			  # Print space
	li	$v0, 4
	syscall

	mul $s2, $s0, $s0		  # Calculate a^2-2b^2
	mul $s3, $s1, $s1
	sll $s3, $s3, 1
	sub $s2, $s2, $s3
	
	li $v0, 1                 # Print a^2-2b^2
	addu $a0, $s2, $0
    syscall
	
	la	$a0, space			  # Print space
	li	$v0, 4
	syscall
			  
	mtc1 $s0, $f1			  # Convert a and b int to floating-point single presicion
	mtc1 $s1, $f2
	cvt.s.w $f1, $f1
	cvt.s.w $f2, $f2
	
	div.s $f1, $f1, $f2		  # Calculate a/b
	
	li $v0, 2                 # Print a/b
	mov.s $f12, $f1
    syscall
	
	la	$a0, newLine		  # Print \n
	li	$v0, 4
	syscall
	
	addi $s3, $s0, 0
	addi $s2, $s1, 0		  # a = a + 2b
	sll $s2, $s2, 1
	add $s0, $s0, $s2
	
	add $s1, $s3, $s1		  # b = a + b
	
	beq $t1, $t0, end		  # iteration == Count of iteration
	
	j calculateAndPrint       # in loop
end:	
	li $v0, 10  			  # Finish the program
	syscall