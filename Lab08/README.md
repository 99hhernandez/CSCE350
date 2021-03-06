# Introduction
In this lab, you will complete the control unit for the single-cycle ARMv8 processor and assemble all of the datapath components constructed in previous labs using Verilog. You will also execute some test programs on your single-cycle processor. By the end of this lab, you should thoroughly understand the internal operation of the ARMv8 single-cycle processor.

### Processor 
This version of ARMv8 implements the single-cycle processor given in the figure below and supports the following instructions: LDUR, STUR, ADD, SUB, AND, ORR, CBZ and B. The instruction formats are the same as the real ARMv8 instruction set.  Our model of the single-cycle ARMv8 processor divides the machine into two major units: the control and the data path. You have already built many of the datapath components such as the ALU, the data memory, the sign extender, etc.  You are provided with the instruction memory (read only), which is pre-initialized with test programs. Your task is to complete the Main Control unit, connect all modules together, and simulate the code.
![DataPath](full_datapath.png)
