# Salih ÖZYURT  150117855
# Enver ASLAN   150115851

.data

# string constants
greetingStr:    .asciiz "Welcome to our MIPS project!"

menuStr:        .ascii  "\nMain Menu:"
                .ascii  "\n1. Square Root Approximate"
                .ascii  "\n2. Matrix Multiplication"
                .ascii  "\n3. Palindrome"
                .ascii  "\n4. Exit"
                .asciiz "\nPlease select an option: "
wrongStr:       .asciiz "The select option is wrong.\n"
endingStr:      .asciiz "\nProgram ends. Bye :)"

prompt1:        .asciiz "Enter the number of iteration for the series: "
prompt2:        .asciiz "a: "
prompt3:        .asciiz "\nb: "

prompt4:        .asciiz "Enter the first matrix: "
prompt5:        .asciiz "Enter the second matrix: "
prompt6:        .asciiz "Enter the first dimension of first matrix: "
prompt7:        .asciiz "Enter the second dimension of first matrix: "
prompt8:        .asciiz "Multiplication of Matrix:\n"

prompt9:        .asciiz "Enter an input string: "
prompt10:       .asciiz " is palindrome.\n"
prompt11:       .asciiz " is not palindrome.\n"

newLine:        .asciiz "\n"
tab:            .asciiz "\t"
space:          .asciiz " "

input:          .space 1024

.text
.globl main

main:
    li $v0, 4
    la $a0, greetingStr
    syscall


    do:
        jal printMenu

        # read option value from console
        li $v0, 5
        syscall
        add $t0, $zero, $v0         # option = $v0
        
        C1:
            bne $t0, 1, C2          # case 1:
            jal question1           # question1()
            j brk                   # break
        
        C2:
            bne $t0, 2, C3          # case 2:
            jal question2           # question()
            j brk                   # break
        
        C3:
            bne $t0, 3, C4          # case 3:
            jal question3           # question3()
            j brk                   # break
        
        C4:
            bne $t0, 4, default     # case 4: exit
            j brk                   # break

        default:
            li $v0, 4
            la $a0, wrongStr
            syscall                 # print wrongStr
            j brk
        brk:
    while:
    beq $t0, 4, exit
    j do
    exit:    
    li $v0, 4           
    la $a0, endingStr 
    syscall                         # print endstr
    
    li $v0, 10
    syscall                         # end program


# printMenu()
# This function prints the main menu element
printMenu:
    li $v0, 4           
    la $a0, menuStr    
    syscall                         # print menuStr
jr $ra

# quesiton1()
question1:
    addi $sp, $sp, -4
    sw $t0, 0($sp)                  # store the option value in stack

    li $v0, 4
    la $a0, prompt1
    syscall                         # print prompt1
    
    li $v0, 5
    syscall
    add $t0, $zero, $v0             # read sizeArray

    sll $a0, $t0, 2 
    li $v0, 9
    syscall
    add $s1, $v0, $zero             # allocate memory for serie a($1)
    add $t1, $s1, $zero             # tempSerie = a

    sll $a0, $t0, 2 
    li $v0, 9
    syscall                
    add $s2, $v0, $zero             # allocate memory for serie b($t2)
    add $t2, $s2, $zero             # tempserie = b

    li $t3, 1                       # i = 1
    sw $t3, ($s1)                   # a[i] = 1
    sw $t3, ($s2)                   # b[i] = 1
    loop1:
        slt $t4, $t3, $t0
        beq $t4, $zero, exitloop1   # if i > sizeArray break

        lw $t5, ($t1)               # temp_a = a[i]
        lw $t6, ($t2)               # temp_b = b[i]
        sll $t7, $t6, 1             # temp = temp_b * 2            
        add $t6, $t5, $t6           # temp_b = temp_a + temp_b
        add $t5, $t5, $t7           # temp_a = temp_a + temp

        addi $t3, $t3, 1            # i++

        addi $t1, $t1, 4
        sw $t5, ($t1)               # a[i] = temp_a

        addi $t2, $t2, 4
        sw $t6, ($t2)               # b[i] = temp_b        
    j loop1
    exitloop1:

    li $v0, 4
    la $a0, prompt2                 # print prompt2 
    syscall

    add $t1, $s1, $zero
    li $t3, 0                       # i = 0
    printa:
        slt $t4, $t3, $t0
        beq $t4, $zero, exitPrinta  # if i > sizArray break
        
        li $v0, 1
        lw $a0, ($t1)
        syscall                     # print a[i]

        li $v0, 4
        la $a0, space
        syscall                     # print tab
        
        addi $t3, $t3, 1            # i++
        addi $t1, $t1, 4
    j printa
    exitPrinta:

    syscall
    li $v0, 4
    la $a0, prompt3
    syscall                         # print prompt3

    add $t1, $s2, $zero
    li $t3, 0                       # i = 0
    printb:
        slt $t4, $t3, $t0
        beq $t4, $zero, exitPrintb   # if i > sizeArray exit
        
        li $v0, 1
        lw $a0, ($t1)
        syscall                     # print b[i]

        li $v0, 4
        la $a0, space
        syscall                     # print tab
        
        addi $t3, $t3, 1            # i++
        addi $t1, $t1, 4
    j printb
    exitPrintb:

    li $v0, 4
    la $a0, newLine
    syscall                         # print newLine

    lw $t0, 0($sp)                  
    addi $sp $sp, 4                 # free memory space from stack
jr $ra

# Question 2
question2:
    addi $sp, $sp, -8               
    sw $t0, ($sp) 
    sw $ra, 4($sp)                  # store return address, and option value
    
    li $v0, 4
    la $a0, prompt4
    syscall                         # print prompt4
    li $v0, 8
    li $a1, 1024
    la $a0, input
    syscall                         
    add $s0, $a0, $zero             # read matrix mat1($s0) as a string
    jal findMatrixElementCount
    add $t0, $v0, $zero             # elmCount1 = findMatrixElementCount(mat1)

    li $v0, 9
    sll $a0, $t0, 2
    syscall                         # allocate memmory
    add $s2, $v0, $zero             # matrix1 = $v0

    add $a0, $s0, $zero
    add $a1, $s2, $zero
    jal stringToInteger             # stringToInteger(mat1, matrix1)
    add $s0, $s2, $zero


    li $v0, 4
    la $a0, prompt5
    syscall                         # print prompt5
    li $v0, 8
    li $a1, 1024
    la $a0, input
    syscall                         
    add $s1, $a0, $zero             # read matrix mat2($s1) as string
    jal findMatrixElementCount
    add $t1, $v0, $zero             # elmCount2 = findMatrixElementCount(mat2)

    li $v0, 9
    sll $a0, $t1, 2
    syscall                         # allocate memmory
    add $s2, $v0, $zero             # matrix2 = $v0 

    add $a0, $s1, $zero
    add $a1, $s2, $zero
    jal stringToInteger             # stringToInteger(mat2, matrix2)
    add $s1, $s2, $zero

    li $v0, 4
    la $a0, prompt6
    syscall                         # print prompt6
    li $v0, 5
    syscall                         
    add $t3, $v0, $zero             # read firstDimension

    li $v0, 4
    la $a0, prompt7
    syscall                         # print prompt7
    li $v0, 5
    syscall                         
    add $t4, $v0, $zero             # read secondDimension 

    
    rem $t7, $t1, $t4
    bne $t7, $zero, else            # if (elmCount2 % secondDimension == 0)
        add $t5, $t4, $zero         # row2 = secondDimension
        div $t6, $t1, $t4           # col2 = elmCount2 / secondDimension
    j exitIf    
    else:                           # else
        add $t5, $t3, $zero         # row2 = firstDimension
        div $t6, $t1, $t3           # col2 = elmCount / firstDimension
        add $t7, $t3, $zero         # temp = firstDimension
        add $t3, $t4, $zero         # firstDimension = secondDimension (row1)
        add $t4, $t7, $zero         # secondDimension = temp    (col1)
    exitIf:
    

    add $t0, $t3, $zero             # $t0 = row1
    add $t1, $t4, $zero             # $t1 = col1
    add $t2, $t5, $zero             # $t2 = row2  
    add $t3, $t6, $zero             # $t3 = col2

    li $v0, 9
    mul $a0, $t0, $t3
    sll $a0, $a0, 2
    syscall                         # allocate memmory
    add $s2, $v0, $zero             # resultMatrix = $v0

    # Matrix multiplication
    li $v0, 4
    la $a0, prompt8
    syscall
    li $t4, 0
    li $t9, 0
    rowLoop:
        beq $t4, $t0, endrowLoop

        li, $t5, 0
        colLoop:
            beq $t5, $t3, endColLoop

            li $t6, 0
            insideLoop:
                beq $t6, $t1 endInsideLoop

                add $t7, $s0, $zero         # $t7 is base address of array (first array)
                addi $a0, $t4, 0            # $t4 is row        
                addi $a1, $t6, 0            # $t6 is col
                add $t8, $t1, $zero         # $t8 is column upperbound
                jal getElementAddress       # getElementAddres(base, row, col, clb)
                add $s3, $v1, $zero         # $s3 is location of element

                add $t7, $s1, $zero         # $t7 is base address of array (second array)
                addi $a0, $t6, 0            # $t6 is row
                addi $a1, $t5, 0            # $t5 is col
                add $t8, $t3, $zero         # $t8 is column uppercound
                jal getElementAddress       # getElementAddres(base, row, col, clb)
                add $s4, $v1, $zero         # $t4 is location of element

                lw $s5, ($s3)               
                lw $s6, ($s4)
                mul $s5, $s5, $s6           # $s5 = $s5 * $s6
                add $t9, $t9, $s5           # $t9 = $t9 + $s5

                addi $t6, $t6, 1            # $t6++
            j insideLoop
            endInsideLoop:

            add $t7, $s2, $zero             # $t7 is base address of array (multiplication array)
            addi $a0, $t4, 0                # $t4 is row
            addi $a1, $t5, 0                # $t5 is col
            add $t8, $t3, $zero             # $t8 is column uppercound
            jal getElementAddress           # getElementAddres(base, row, col, clb)
            add $s7, $v1, $zero             # $s7 is location of element
            sw $t9, ($s7)                   # store $t9 value location of multiplication array
            li $t9, 0                       # $t9 = 0

            li $v0, 1
            lw $a0, ($s7)
            syscall                         # write element of multiplication array

            li $v0, 4
            la $a0, tab
            syscall                         # write tab

            addi $t5, $t5, 1                # $t5 = $t5 + 1
        j colLoop
        endColLoop:
        
        li $v0, 4
        la $a0, newLine
        syscall                             # write newline

        addi $t4, $t4, 1                    # $t4 = $t4 + 1
    j rowLoop
    endrowLoop:

    lw $t0, ($sp) 
    lw $ra, 4($sp)                  
    addi $sp $sp, 8                 # free memory space from stack
jr $ra                              # return

# Find matrix element count
findMatrixElementCount:
    addi $sp, $sp, -4
    sw $t0, ($sp) 
    
    add $t0, $a0, $zero                 # tempStr = arg0
    lbu $t1, ($t0)                      # chr = tempStr[0]
    li $t2, 1                           # size = 1
    counterLoop:
	    beq $t1, $zero, endCounterLoop  # if chr = '\0' break
	    addi $t0, $t0,1                 # tempStr = &tempStr[1]
	    lbu $t1, ($t0)                  # chr = tempStr[0]
        bne $t1, 32, counterLoop        # if chr = ' ' continue
	    addi $t2, $t2, 1                # else size++
    j counterLoop
    endCounterLoop:
    add $v0, $t2, $zero                 # returnValeu = size

    lw $t0, ($sp)
    addi $sp, $sp, 4                    # return
jr $ra

# stringToInteger
stringToInteger:
    addi $sp, $sp, -8
    sw $t0, ($sp)
    sw $t1, 4($sp)

    add $t0, $a0, $zero                 # tempStr = arg0
    add $t3, $a1, $zero                 # temparr = arg1[]
    lbu $t1, ($t0)                      # chr = tempStr[0]
    li $t2, 0
    do1:
        beq $t1, 32, else1
        beq $t1, 10, while1             # if chr !=' ' || chr != '\n'
            mul $t2, $t2, 10            # number = number * 10
            addi $t4, $t1, -48          # tempNumber = tempNumber - 48
            add $t2, $t2, $t4           # number = number + tempNumber
            addi $t0, $t0,1             # tempStr = &tempStr[1]
            lbu $t1, ($t0)              # chr = tempStr[0]
            j do1                       # continue
        else1:
            sw $t2, ($t3)               # temparr[0] = number 
            addi $t0, $t0, 1            # tempStr = &tempStr[1]
	        lbu $t1, ($t0)              # chr = tempStr[0]
            addi $t3, $t3, 4            # &temparr = &temparr + 4 
            li $t2, 0                   # number = 0
            j do1
    while1:
        sw $t2, ($t3)                   # temparr[0] = number 
        beq $t1, 10, exit1
        j do1
    exit1:

    lw $t0, ($sp)
    lw $t1, 4($sp)
    addi $sp, $sp, 8
jr $ra

getElementAddress:
    addi $sp, $sp, -12
    sw $s0, ($sp)
    sw $t0, 4($sp)
    sw $t1, 8($sp)

    add $s0, $t7, $zero             # base address
    addi $t1, $t8, -1               # col upperbound
    
    addi $t1, $t1, 1                # col upperbound + 1 
    mul $t0, $a0, $t1               
    add $t0, $t0, $a1
    sll $t0, $t0, 2
    add $v1, $s0, $t0

    lw $s0, ($sp)
    lw $t0, 4($sp)
    lw $t1, 8($sp)
    addi $sp, $sp, 12
jr $ra


# Question 3
question3:
    addi $sp, $sp, -4               # loan space from stack
    sw $t0, 0($sp)                  # store the option value in stack

    li $v0, 4                 # Print start
	la $a0, prompt9
    syscall
	
    li $v0, 8				  # Read input
    li $a1, 1024
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
			
			la	$a0, prompt10	  # Print palindrome message
			li	$v0, 4
			syscall
			
			j end
			
		notPalindromeEnd:
			la	$a0, input		   # Print input
			li	$v0, 4
			syscall
			
			la	$a0, prompt11 # Print notPalindrome message
			li	$v0, 4
			syscall
			
			j end

    end:

    lw $t0, 0($sp)                  # load the option value from stack
    addi $sp $sp, 4                 # free memory space from stack
    jr $ra