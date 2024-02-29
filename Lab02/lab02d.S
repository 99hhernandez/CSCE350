.section .text

.globl lab02d

lab02d:
	ADD X0, X0, #1000		//adds 100 to X0
	ADRP X5, myvalue		//loads top 21 bits of myvalue to X5
	ADD X5, X5, :lo12:myvalue	//loads last 12 bits of my value to X5
	STUR X0, [X5, 0]		//stores 
	BR X30

.section .data
	myvalue:	.byte 16