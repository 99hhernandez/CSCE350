.section .text

	.globl lab03b

lab03b:
	MOVZ X1, #10			//assigns 10 to X1 (i=10)

loop:
	CBZ X1, finish			//if(i == 0) -> finish
	SUB X0, X0, #1			//UIN -= 1
	SUB X1, X1, #1			//i--
	B loop				    //loop again

finish:
	BR X30

.section .data
	UIN: .byte 8			//UIN stored in X0