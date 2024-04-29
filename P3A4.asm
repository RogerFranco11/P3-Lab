# Title:  					Filename:
# Author:  				Date:
# Description:
#   // C++ Code
#   for(i=0;i<5;i++){
#   	cin >> num[i];
#   	if (i == 0) min = num[i];
#       if ( min > num[i])
#           min = num[i]; 
#    }
#   cout << “min: “ <<  min << endl;
# Input:
# Output:
################# Data segment #####################
.data
    num:    .space 20
    min:    .word 0 
################# Code segment #####################
.text
.globl main

main:  	
    li  $t0, 0
    la  $t1, num
    La  $t2, min

loop:
    # Read an integer from input
    li   $v0, 5
    syscall
    # Store the read value in num[i]
    sw   $v0, ($t1)
    # If i == 0, initialize min with num[i]
    beq  $t0, $zero, update_min
    # Load min into $t3
    lw   $t3, ($t2)
    # Load num[i] into $t4
    lw   $t4, ($t1)
    # Compare min with num[i]
    slt  $t5, $t4, $t3
    # If num[i] < min, update min
    bne  $t5, $zero, update_min
    
    # Increment loop counter (i)
    addi $t0, $t0, 1
    # Increment num pointer to point to the next element
    addi $t1, $t1, 4
    # Check if loop counter (i) < 5
    blt  $t0, 5, loop
    
    # Print out the minimum value
    lw   $a0, min
    li   $v0, 1
    syscall
    
    # Exit program
    li   $v0, 10
    syscall

update_min:
    # Store num[i] into min
    lw   $t3, ($t1)
    sw   $t3, ($t2)
    # Increment loop counter (i)
    addi $t0, $t0, 1
    # Increment num pointer to point to the next element
    addi $t1, $t1, 4
    # Check if loop counter (i) < 5
    blt  $t0, 5, loop 