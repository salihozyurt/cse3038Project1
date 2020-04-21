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
prompt8:        .asciiz "Multiplication of Matrix:"

prompt9:        .asciiz "\nEnter an input string: "
prompt10:       .asciiz "\n is palindrome."
prompt11:       .asciiz "\n is not palindrome."



newLine:        .asciiz "\n"
tab:            .asciiz "\t"
space:          .asciiz " "

input:          .space 1024
matrix1:        .space 800
matrix2:        .space 800


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

    li $v0, 4
    la $a0, prompt6
    syscall                         # print prompt6
    li $v0, 5
    syscall                         
    move $t3, $v0                   # read firstDimension

    li $v0, 4
    la $a0, prompt6
    syscall                         # print prompt6
    li $v0, 5
    syscall                         
    move $t4, $v0                   # read secondDimension 

    li $v0, 1
    add $a0, $t0, $zero
    syscall

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



# Question 3
question3:
    addi $sp, $sp, -4               # loan space from stack
    sw $t0, 0($sp)                  # store the option value in stack

    lw $t0, 0($sp)                  # load the option value from stack
    addi $sp $sp, 4                 # free memory space from stack
    jr $ra