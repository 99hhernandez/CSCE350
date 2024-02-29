#include <stdio.h>
extern long long int lab02d(long long int b);

int main(void)
{
    long long int a = lab02d(2021);
    printf("The address of your value is: %p\n", a);
    printf("Your new value is: %d\n", a);
    return 0;
}
