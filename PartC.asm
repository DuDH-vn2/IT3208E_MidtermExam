.data
	str: .space 1000
	cntC: .word 0 : 26 
	cmd: .asciz "Enter your string: "
	str1: .asciz "The most frequent uppercase character is: "
	str2: .asciz "It has "
	str3: .asciz " times of appearing\n"
	str4: .asciz "It's location is: "
	str5: .asciz "There not exist uppercase letter"
.text
	li a7, 4
	la a0, cmd
	ecall
	li a7, 8
	la a0, str
	li a1, 100
	ecall
	
	la s0, str 
	la s1, cntC 

	li t0, 0
	li t1, 25
beZero: 
	bge t0, t1, endbeZero
	slli t2, t0, 2
	add t2, t2, s1
	sw zero, 0(t2)
	addi t0, t0, 1
	j beZero
endbeZero:
strlen:
	li t0, 0
	li s11, 0 
for0:
	add t1, t0, s0
	lb t2, 0(t1)
	beq t2, zero, endfor0
	addi s11, s11, 1
	addi t0, t0, 1
	j for0
endfor0:
	addi s11, s11, -1

	li t0, 0
	li s10, 65 
	li s9, 90 
for1:
	bge t0, s11, endfor1
	add t1, t0, s0
	lb t2, 0(t1)
	bge t2, s10, ok1

	addi t0, t0, 1
	j for1
ok1:
	ble t2, s9, ok2

	addi t0, t0, 1
	j for1
ok2:
	sub t3, t2, s10
	slli t3, t3, 2
	add t3, t3, s1
	lw t4, 0(t3)
	addi t4, t4, 1
	sw t4, 0(t3)
	addi t0, t0, 1
	j for1
endfor1:

	li t0, 0
	li s3, 0x80000000 
	mv s4, zero
for2:
	bge t0, s11, endfor2
	slli t1, t0, 2
	add t1, t1, s1
	lw t2, 0(t1)
	bgt t2, s3, changeMax
	addi t0, t0, 1
	j for2
changeMax:
	mv s3, t2
	add s4, s10, t0
	addi t0, t0, 1
	j for2
endfor2:
checkExistence:
	beq s3, zero, noExist
	li s8, 0x80000000
	beq s3, s8, noExist
Exist:
	li a7, 4
	la a0, str1
	ecall
	li a7, 11
	mv a0, s4
	ecall
	li a7, 11
	li a0, 10
	ecall
	li a7, 4
	la a0, str2
	ecall
	li a7, 1
	mv a0, s3
	ecall
	li a7, 4
	la a0, str3
	ecall
	li a7, 4
	la a0, str4
	ecall

	li t0, 0
for3:
	bge t0, s11, endfor3
	add t1, t0, s0
	lb t2, 0(t1)
	beq t2, s4, print
	addi t0, t0, 1
	j for3
print:
	li a7, 1
	mv a0, t0
	ecall
	li a7, 11
	li a0, 32
	ecall
	addi t0, t0, 1
	j for3
endfor3:
	li a7, 10
	ecall
noExist:
	li a7, 4
	la a0, str5
	ecall
	li a7, 10
	ecall
	
