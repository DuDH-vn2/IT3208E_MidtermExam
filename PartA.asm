#exercise 11
.data
	str: .space 100
	msgError: .asciz "Error"
	str1: .asciz "Odd sum is: "
	str2: .asciz "Even sum is: "
	str3: .asciz "Invalid input, please enter value again: "
.text
beginEntering:
	.text
	li a7, 8
	la a0, str
	li a1, 100
	ecall
# from this we will enter then check input for the right form (at least 5-digits 32-bit non-negative signed number)
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
# end input process
	li s0, 0 
	li s1, 0 
	li s3, 10
	mv t0, a0 
	li t1, 0 
whileLoop0:
	beqz t0, endWhileLoop0 
	addi t1, t1, 1
	li t2, 10
	div t0, t0, t2 
	j whileLoop0 
endWhileLoop0:
	li t2, 5 
	bge t1, t2, whileLoop1
	li a7, 4
	la a0, str3 
	ecall 
	j beginEntering

whileLoop1: 
	beqz a0, endWhile1
	rem t0, a0, s3 
	andi t1, t0, 0x1 
	bgtz t1, OddNum

EvenNum:
	add s1, s1, t0
	div a0, a0, s3
	j whileLoop1
OddNum:
	add s0, s0, t0
	div a0, a0, s3
	j whileLoop1
endWhile1:
	li a7, 4
	la a0, str1
	ecall 
	li a7, 1
	mv a0, s0
	ecall
	li a7, 11
	li a0, 10
	ecall
	li a7, 4
	la a0, str2
	ecall
	li a7, 1
	mv a0, s1
	ecall
endMain:
	li a7, 10
	ecall
