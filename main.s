# Salih ÖZYURT  150117855
# Enver ASLAN   150115851


.data
greetingStr:    .asciiz "Welcome to our MIPS project!"

menuStr:        .ascii  "\nMain Menu:"
                .ascii  "\n1. Square Root Approximate"
                .ascii  "\n2. Matrix Multiplication"
                .ascii  "\n3. Palindrome"
                .ascii  "\n4. Exit"
                .asciiz "\nPlease select an option: "

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
endingMessage:       .asciiz "\n Program ends. Bye :)"

newLine:        .asciiz "\n"

.text
.globl main

main:
    li $v0, 4
    la $a0, greetingStr
    syscall

    # $t0 represents option variable
    li $t0, -1           # $t0 = -1
    while:
        beq $t0, 4, endWhile # if $t0 = 4, then go endWhile

        jal printMenu   # call the printMenu function

        li $v0, 5       # set trap code as 5 to read integer
        syscall         # read integer from console
        add $t0, $zero, $v0 # $t0 = $v0 
        j while


    endWhile:
    # print the ending message
    li $v0, 4           # set trap code as 4 to print string
    la $a0, endingMessage # $a0 = endingMessage
    syscall             # print message

    # send a signal to the system to terminate the program
    li $v0, 10
    syscall


# print the main menu
printMenu:
    li $v0, 4           # set trap code as 4 to print string
    la $a0, menuStr     # $a0 = menustr
    syscall             # print the menu
    jr $ra              # return
