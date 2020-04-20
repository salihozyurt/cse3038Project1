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

prompt1:        .asciiz "\nEnter the number of iteration for the series: "
prompt2:        .asciiz "\na: "
prompt3:        .asciiz "\nb: "

prompt4:        .asciiz "\nEnter the first matrix: "
prompt5:        .asciiz "\nEnter the second matrix: "
prompt6:        .asciiz "\nEnter the first dimension of first matrix: "
prompt7:        .asciiz "\nEnter the second dimension of first matrix: "
prompt8:        .asciiz "\nMultiplication of Matrix:"

prompt9:        .asciiz "\nEnter an input string: "
prompt10:       .asciiz "\n is palindrome."
prompt11:       .asciiz "\n is not palindrome."

endingMessage:  .asciiz "\nProgram ends. Bye :)"

newLine:        .asciiz "\n"
tab:            .asciiz "\t"


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
        
        slti $t1, $t0, 5
        beq $t1, $zero, default     # if option > 4 go to default
        beq $t0, $zero, default     # if option == 0 go to default

        C1:
            bne $t0, 1, C2          # if option != 1 go to C2
            jal question1
            j brk                   # break
        
        C2:
            bne $t0, 2, C3          # if option != 2 go to C3
            jal question2
            j brk                   # break
        
        C3:
            bne $t0, 3, C4          # if option != 3 go to C4
            jal question3
            j brk                   # break
        
        C4:
            j brk                   # break

        default:
            # print the wrong choosing message
            li $v0, 4
            la $a0, wrongStr
            syscall
            j brk
        brk:
    while:
    beq $t0, 4, exit
    j do

    exit:
    # print the ending message
    li $v0, 4           
    la $a0, endingMessage 
    syscall             

    # send a signal to the system to terminate the program
    li $v0, 10
    syscall


# print the main menu
printMenu:
    li $v0, 4           
    la $a0, menuStr    
    syscall             
    jr $ra

# Question 1
question1:
    addi $sp, $sp, -4               # loan space from stack
    sw $t0, 0($sp)                  # store the option value in stack

    li $v0, 4
    la $a0, prompt1
    syscall                         # print the prompt1
    
    li $v0, 5
    syscall
    add $t0, $zero, $v0             # read size of series from console

    sll $a0, $t0, 2 
    li $v0, 9
    syscall                         # allocate the memory space for a
    add $s1, $v0, $zero             # $s1 represents the address of a
    add $t1, $s1, $zero             # $t1 represents the temp of a

    sll $a0, $t0, 2 
    li $v0, 9
    syscall                         # allocate the memory space for b
    add $s2, $v0, $zero             # $s2 represents the address of b
    add $t2, $s2, $zero             # $t2 represents the temp of a

    li $t3, 1                       # $t3 represents the iteration i = 1
    sw $t3, ($s1)
    sw $t3, ($s2)
    loop1:
        slt $t4, $t3, $t0
        beq $t4, $zero, exitloop1   # if i > n , then go to exitloop 

        lw $t5, ($t1)
        lw $t6, ($t2)
        sll $t7, $t6, 1             # temp=2*b[i]
        add $t6, $t5, $t6           # $t5 = a[i] + b[i]
        add $t5, $t5, $t7           # $t6 = a[i] + temp

        addi $t3, $t3, 1            # i++
        addi $t1, $t1, 4
        sw $t5, ($t1)               # a[i+1] = $t5
        addi $t2, $t2, 4
        sw $t6, ($t2)               # b[i+1] = $t6        
    j loop1
    exitloop1:

    li $v0, 4
    la $a0, prompt2                 # print prompt2 
    syscall
    add $t1, $s1, $zero
    li $t3, 0
    printa:
        slt $t4, $t3, $t0
        beq $t4, $zero, exitPrinta   # if i > n , then go to exitloop 
        
        li $v0, 1
        lw $a0, ($t1)
        syscall                     # print a[i]

        li $v0, 4
        la $a0, tab
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
    li $t3, 0
    printb:
        slt $t4, $t3, $t0
        beq $t4, $zero, exitPrintb   # if i > n , then go to exitloop 
        
        li $v0, 1
        lw $a0, ($t1)
        syscall                     # print a[i]

        li $v0, 4
        la $a0, tab
        syscall                     # print tab
        
        addi $t3, $t3, 1            # i++
        addi $t1, $t1, 4
    j printb
    exitPrintb:

    lw $t0, 0($sp)                  # load the option value from stack
    addi $sp $sp, 4                 # free memory space from stack
    jr $ra



# Question 2
question2:
    addi $sp, $sp, -4               # loan space from stack
    sw $t0, 0($sp)                  # store the option value in stack

    lw $t0, 0($sp)                  # load the option value from stack
    addi $sp $sp, 4                 # free memory space from stack
    jr $ra

# Question 3
question3:
    addi $sp, $sp, -4               # loan space from stack
    sw $t0, 0($sp)                  # store the option value in stack

    lw $t0, 0($sp)                  # load the option value from stack
    addi $sp $sp, 4                 # free memory space from stack
    jr $ra