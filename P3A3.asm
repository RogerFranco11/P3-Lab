# Title:  					Filename:
# Author:  				Date:
# Description:
#   // C++ Code
#   for(i=0;i<5;i++){
#   	cin >> num[i];
#      	total += num[i]; 
#   }
#   cout << “Total: “ <<  total << endl;
# Input:
# Output:
################# Data segment #####################
.data
    num:    .space 20
    N:      .word 5
    total:  .word 0
################# Code segment #####################
.text
.globl main

main: 
    # Load address of num into $t0
    la   $t0, num
    # Load the number of iterations into $t2
    lw   $t2, N

loop:
    # Read an integer from input
    li   $v0, 5
    syscall
    # Store the read value in num[i]
    sw   $v0, 0($t0)
    # Increment the total
    lw   $t3, total
    add  $t3, $t3, $v0
    sw   $t3, total

    # Increment the loop counter
    addi $t1, $t1, 1
    # Compare the loop counter with the number of iterations
    slt  $t4, $t1, $t2
    # Branch back to loop if not finished
    bne  $t4, $zero, loop

    # Print out the total
    lw   $a0, total
    li   $v0, 1
    syscall

    # Exit program
    li   $v0, 10
    syscall