.data
	str: .space 100
	str1: .asciz "Error"
.text
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
	blt t2, s10, error # number checking
	bgt t2, s9, error # number checking
	bltz a0, error # overflow check
	sub t3, t2, s10
	li t4, 10
	mul a0, a0, t4
	add a0, a0, t3
	addi t0, t0, 1
	j checkValidString
error:
	mv t0, a0
	la a0, str1 #error message 
	li a7, 4
	ecall
	li a7, 10
	ecall
endCheckValidString:
	
	
	
