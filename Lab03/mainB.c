/* main.c simple program to test assembler program */

#include <stdio.h>

extern long long int lab03b(long long int b);

int main(void)
{
    long long int a = lab03b(38);       // UIN: 127008848
    printf("New UIN: %ld\n", a);
    return 0;
}