# Title:  					Filename:
# Author:  				Date:
# Description:
#   // C++ Code
#   int N = 10;
#   char letters[N] = “aacdeaaai\n”;
#   char	key;
#   cin >> key;
#   for(i=0;i<10;i++){
#   	if (letters[i] == key) 
#   cnt += 1;
#   }
#   cout << “Count: “ <<  cnt << endl;
# Input:
# Output:
################# Data segment #####################
.data
    N:          .word 10           # Number of elements in the array
    letters:    .asciiz "aacdeaaai\n"   # String of characters
    key:        .space 1           # Space for the key character
    cnt:        .word 0            # Initialize count variable to 0
################# Code segment #####################
.text
.globl main
main:  	
    # Load the address of the letters array into $t0
    la   $t0, letters
    # Load the address of the key variable into $t1
    la   $t1, key
    # Load the address of the cnt variable into $t2
    la   $t2, cnt

    # Read a character from input and store it in key
    li   $v0, 12
    syscall
    # Store the read character into key
    sb   $v0, ($t1)

    # Loop from i=0 to N-1
    li   $t3, 0           # Initialize loop counter (i) to 0
loop:
    # Check if i >= N
    bge  $t3, N, endloop
    # Load the character from letters[i] into $t4
    lb   $t4, ($t0)
    # Compare the character with the key
    beq  $t4, $zero, not_equal    # If letters[i] is null terminator, jump to not_equal
    beq  $t4, ($t1), increment_cnt  # If letters[i] equals key, increment count
not_equal:
    # Increment the pointer to letters array (move to next character)
    addi $t0, $t0, 1
    # Increment loop counter (i)
    addi $t3, $t3, 1
    # Repeat the loop
    j    loop
increment_cnt:
    # Increment cnt
    lw   $t5, ($t2)       # Load current value of cnt
    addi $t5, $t5, 1      # Increment cnt
    sw   $t5, ($t2)       # Store the updated value back to cnt
    # Increment the pointer to letters array (move to next character)
    addi $t0, $t0, 1
    # Increment loop counter (i)
    addi $t3, $t3, 1
    # Repeat the loop
    j    loop
endloop:
    # Print out the count
    lw   $a0, cnt          # Load cnt into $a0 for printing
    li   $v0, 1            # Load the print integer syscall code into $v0
    syscall

    # Exit program
    li   $v0, 10            # Load the exit syscall code into $v0
    syscall