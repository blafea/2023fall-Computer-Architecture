.globl __start

.rodata
    division_by_zero: .string "division by zero"

.text
__start:
    # Read first operand
    li a0, 5
    ecall
    mv s0, a0
    # Read operation
    li a0, 5
    ecall
    mv s1, a0
    # Read second operand
    li a0, 5
    ecall
    mv s2, a0

###################################
#  TODO: Develop your calculator  #
#                                 #
###################################

    li  t0,0
    li  t1,1
    li  t2,2
    li  t3,3
    li  t4,4
    li  t5,5
    li  t6,6

#Add
    add s3,s0,s2
    beq s1,x0,output
#Sub
    sub s3,s0,s2
    beq s1,t1,output
#Mul
    mul s3,s0,s2
    beq s1,t2,output  
#Div
    beq s1,t3,division
#Min
    beq s1 t4 min
#Power
    beq s1,t5,power
#Fact
    beq s1,t6,fact

division:
    beq s2,x0,division_by_zero_except
    div s3,s0,s2
    beq s1,t3,output
    
min:
    sub s3,s0,s2
    blt s3,x0,x0_min
    add s3,s2,x0
    beq s1,t4,output
    
x0_min:
    add s3,s0,x0
    beq s1,t4,output

power:
    add t5,s0,x0
    addi s3,x0,1
power2:
    beq x0,s2,output
    mul s3, s3,s0
    addi s2, s2, -1
    jal x0,power2

fact:
    addi s3,x0,1
fact2:
    blt s0,t1,output
    mul s3,s3,s0
    addi s0,s0,-1
    jal x0,fact2

output:
    # Output the result
    li a0, 1
    mv a1, s3
    ecall

exit:
    # Exit program(necessary)
    li a0, 10
    ecall

division_by_zero_except:
    li a0, 4
    la a1, division_by_zero
    ecall
    jal zero, exit
