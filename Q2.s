# 150117855 Salih Özyurt
# 150115851 Enver ASLAN

				.data
input1:   	  	.space 512
input2:   	  	.space 512
temp1:   	  	.space 1024
temp2:   	  	.space 1024
output:   	  	.space 1024
prompt1:   	  	.asciiz "Enter the first matrix: "
prompt2:   	  	.asciiz "Enter the second matrix: "
prompt3:   	  	.asciiz "Enter the first dimension of first matrix: "
prompt4:   	  	.asciiz "Enter the second dimension of first matrix: "
result:  		.asciiz "Multiplication matrix: "
				.text
				.globl main
main:
	li $v0, 4                 # Print prompt1
	la $a0, prompt1
    syscall
	
    li $v0, 8				  # Read input1
    li $a1, 100
    la $a0, input1
    syscall
	
	li $v0, 4                 # Print prompt2
	la $a0, prompt2
    syscall
	
    li $v0, 8				  # Read input2
    li $a1, 100
    la $a0, input2
    syscall
	
	li $v0, 4                 # Print prompt3
	la $a0, prompt3
    syscall
	
	li $v0, 5				  # Read fisrt dimension
    syscall
    addu $t0, $v0, $0         # t0 = first dimension
	
	li $v0, 4                 # Print prompt4
	la $a0, prompt4
    syscall
	
	li $v0, 5				  # Read second dimension
    syscall
    addu $t1, $v0, $0         # t1 = second dimension

    li $t2, 0				   # t2 = 0 first matrix length
	li $t3, 0				   # t3 = 0 second matrix length

strToIntForFisrtMatrix:
	li $t4, 0				   # t4 = 0 iterator for input1
	li $t5, 0				   # t5 = 0 iterator for temp1
	li $s0, -1				   # s0 = -1 for control multi-digit
	Loop:
		lb $t6, input1($t4)		     	 # t6 = input1[t4]
		beq $t6, 10, saveTheLastNumber	 # if t6 == '\n'
		beq $t6, 32, saveTheNumber 	 	 # if t6 == ' '
		beq $s0, -1, tempFunc  			 # if s0 == 0
		bne $s0, -1, multiDigit  		 # if s0 != 0 so it has multi-digit
	
		tempFunc:
			sub $t6, $t6, 48		  # t6 -= 48
			add $s0, $t6, 0			  # s0 = t6
			add $t4, $t4, 1		   	  # iterator for input1 += 1
			j Loop
			
		multiDigit:
			mul $s0, $s0, 10		  # s0 = s0 * 10
			sub $t6, $t6, 48		  # t6 -= 48
			add $s0, $s0, $t6		  # s0 = s0 + t6
			add $t4, $t4, 1		   	  # iterator for input1 += 1
			j Loop
		
		saveTheNumber:
			add $t2, $t2, 1		       # first matrix length += 1
			sw $s0, temp1($t5)		   # temp1[t5] = s0 as a int
			li $s0, -1				   # s0 = -1
			add $t5, $t5, 4		       # iterator for temp1 += 4
			add $t4, $t4, 1		       # iterator for input1 += 1
			j Loop

	saveTheLastNumber:
		add $t2, $t2, 1		       # first matrix length += 1
		sw $s0, temp1($t5)		   # temp1[t5] = s0 as a int
		j writeFirstMatrix
	
writeFirstMatrix:
	li $v0, 1              # print length
    addu $a0, $t2, $0
    syscall

	li $t4, 0				   # t4 = 0 iterator for temp1
	Loop1:
		lw $t5, temp1($t4)	   # t5 = temp1[t4]
		beq $t5, 0, strToIntForSecondMatrix	 	   # if t5 == 0
		
		li $v0, 1              # print element
        addu $a0, $t5, $0
        syscall
		
		add $t4, $t4, 4		       # iterator for temp1 += 4
		j Loop1

strToIntForSecondMatrix:
	li $t4, 0				   # t4 = 0 iterator for input2
	li $t5, 0				   # t5 = 0 iterator for temp2
	li $s0, -1				   # s0 = -1 for control multi-digit
	Loop2:
		lb $t6, input2($t4)		     	 # t6 = input2[t4]
		beq $t6, 10, saveTheLastNumber1	 # if t6 == '\n'
		beq $t6, 32, saveTheNumber1 	 # if t6 == ' '
		beq $s0, -1, tempFunc1  		 # if s0 == 0
		bne $s0, -1, multiDigit1  		 # if s0 != 0 so it has multi-digit
	
		tempFunc1:
			sub $t6, $t6, 48		  # t6 -= 48
			add $s0, $t6, 0			  # s0 = t6
			add $t4, $t4, 1		   	  # iterator for input1 += 1
			j Loop2
			
		multiDigit1:
			mul $s0, $s0, 10		  # s0 = s0 * 10
			sub $t6, $t6, 48		  # t6 -= 48
			add $s0, $s0, $t6		  # s0 = s0 + t6
			add $t4, $t4, 1		   	  # iterator for input1 += 1
			j Loop2
		
		saveTheNumber1:
			add $t3, $t3, 1		       # second matrix length += 1
			sw $s0, temp2($t5)		   # temp2[t5] = s0 as a int
			li $s0, -1				   # s0 = -1
			add $t5, $t5, 4		       # iterator for temp2 += 4
			add $t4, $t4, 1		       # iterator for input2 += 1
			j Loop2

	saveTheLastNumber1:
		add $t3, $t3, 1		       # first matrix length += 1
		sw $s0, temp2($t5)		   # temp2[t5] = s0 as a int
		j writeSecondMatrix
	
writeSecondMatrix:
	li $v0, 1              # print length
    addu $a0, $t3, $0
    syscall

	li $t4, 0				   # t4 = 0 iterator for temp1
	Loop3:
		lw $t5, temp2($t4)	   # t5 = temp1[t4]
		beq $t5, 0, end	 	   # if t5 == 0
		
		li $v0, 1              # print element
        addu $a0, $t5, $0
        syscall
		
		add $t4, $t4, 4		       # iterator for temp1 += 4
		j Loop3

matrixMultiplication:
	li $s0, 0				   # t4 = 0 iterator for temp1
	li $s1, 0				   # t4 = 0 iterator for temp1
	li $s2, 0				   # t4 = 0 iterator for temp1
	
	Loop4:
		

end:
    li $v0, 10
    syscall