# INTRODUCTION

The design in this lab will demonstrate the ways in which Verilog encoding makes hardware design more efficient. It is possible to design a 64-bit ALU from 1-bit ALUs. (i.e.,  you could program a 1-bit ALU that implements a full adder, chain four of these together to make a 4-bit ALU, and chain 16 of those together to make a 64-bit ALU.) However, it is easier (both in time and lines of code) to code it succinctly in Verilog. It is even easier, however, to design a module to be inefficient or incorrect, so care must be taken in design.


## Lab Overview

This lab will use the Verilog hardware description language to implement and verify a 64-bit sign extender module, a register file and the ALU module. Note: the modules implemented in this lab and several labs following will be used as building blocks for a complete single cycle processor.


### Design of the Sign Extender Module
The sign extender  module should take two inputs: Instruction bits 25-0 and a two-bit control signal, and should output a 64-bit extended immediate.


### Design of an ALU
The design of this ALU provides support for implementing the following instructions: AND, ORR, ADD, SUB, LDUR, STUR, and CBZ. All operations have a delay of 20 before the output is available. Used non-blocking assignments. The ALU implements the following operations:

| Operation |	ALU Control Line |
| --------- | ---------------- |
|   AND   	|       0000       |
|   OR	    |       0001       |
|   ADD	    |       0010       |
|   SUB	    |       0110       |
|   PassB	  |       0111       |

- Ports BusA, BusB, and BusW are 64 bits wide.
- ALUCtrl is 4 bits wide, supporting up to 16 functions.
- Port Zero is a boolean variable that is ‘true’ (1) when BusW is 0, and ‘false’ (0) otherwise
