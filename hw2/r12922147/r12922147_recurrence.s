.globl __start

.text
__start:
    # Read first operand
    li a0, 5
    ecall
    mv s0, a0
    
    li t0 0
    li t1 1
    mv s3 t0
    beqz a0 output
    mv s3 t1
    addi a0 a0 -1
    beqz a0 output
loop:
    mv s3 t0
    add s3 s3 t1
    add s3 s3 t1
    addi a0 a0 -1
    beqz a0 output
    mv t0 t1
    mv t1 s3
    jal x0 loop


output:
    # Output the result
    li a0, 1
    mv a1, s3
    ecall

exit:
    # Exit program(necessary)
    li a0, 10
    ecall