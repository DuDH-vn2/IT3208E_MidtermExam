.data
	A: .space 400 
	msgError: .asciz "Error"
	str: .space 100
	str1: .asciz "Enter number of element: "
	str2: .asciz "Invalid number of element, please try again!"
	str3: .asciz "The smallest odd number larger than all even number is: "
	str4: .asciz "The smallest odd number larger than all even number does not exist!"
.text

begin:
	li a7, 4 
	la a0, str1
	ecall
	jal beginCheck # check if user enter the right input (positive 32-bit signed number only)
	mv s0, a0 
	la s1, A 
	bgez s0, continue
invalidN: 
	li a7, 4 
	la a0, str2
	ecall
	li a7, 11 
	li a0, 10
	ecall
	j begin
continue:
	
 	li t0, 0
for0: 
	bge t0, s0, endfor0
	slli t1, t0, 2
	add t1, t1, s1
	#li a7, 5
	#ecall
	jal beginCheck
	sw a0, 0(t1) 
	addi t0, t0, 1
	j for0
endfor0:
	
	li t0, 0
	li s3, 0x80000000 
for1:
	bge t0, s0, endfor1
	slli t1, t0, 2
	add t1, t1, s1
	lw t2, 0(t1) 
	andi t3, t2, 1
	beqz t3, even

	addi t0, t0, 1
	j for1
even:
	bgt t2, s3, changeMax
	addi t0, t0, 1
	j for1
changeMax:
	mv s3, t2
	addi t0, t0, 1
	j for1
endfor1:


	li t0, 0
	li s4, 0x7fffffff 
for2:
	bge t0, s0, endfor2
	slli t1, t0, 2
	add t1, t1, s1 
	lw t2, 0(t1) 
	andi t3, t2, 1
	bgtz t3, odd

	addi t0, t0, 1
	j for2
odd:
	bgt t2, s3, ok
	addi t0, t0, 1
	j for2
ok:
	blt t2, s4, ok1
	addi t0, t0, 1
	j for2
ok1:
	mv s4, t2
	addi t0, t0, 1
	j for2
endfor2:
	li t0, 0x7fffffff
	beq s4, t0, notExist
Exist:
	li a7, 4
	la a0, str3
	ecall
	li a7, 1
	mv a0, s4
	ecall
	li a7, 10
	ecall
notExist:
	li a7, 4
	la a0, str4
	ecall
	li a7, 10
	ecall

beginCheck:
	addi sp, sp, -12
	sw s0, -8(sp)
	sw t0, -4(sp)
	sw t1, 0(sp)
	
	li a7, 8
	la a0, str
	li a1, 100
	ecall
	
	li t0, 0
	la s0, str
strlen:
	add t1, t0, s0
	lb t2, 0(t1)
	beqz t2, endStrlen
	addi t0, t0, 1
	j strlen
endStrlen:
	mv s11, t0
	addi s11, s11, -1
	
	li t0, 0
	li a0, 0
checkValidString:
	bge t0, s11, endCheckValidString
	add t1, t0, s0
	lb t2, 0(t1)
	li s10, 48
	li s9, 57
	blt t2, s10, error
	bgt t2, s9, error
	bltz a0, error
	sub t3, t2, s10
	li t4, 10
	mul a0, a0, t4
	add a0, a0, t3
	addi t0, t0, 1
	j checkValidString
error:
	mv t0, a0
	la a0, msgError #error message 
	li a7, 4
	ecall
	li a7, 10
	ecall
endCheckValidString:
	lw t1, 0(sp)
	lw t0, 4(sp)
	lw s0, 8(sp)
	addi s0, s0, 12
	jr ra
