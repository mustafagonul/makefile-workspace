#include <stdio.h>

void foo();
int  bar();

void foo() 
{
    printf("foo function called.\n");

    int value = bar();
    
    printf("bar = %d\n", value);
    printf("foo function returned.\n");
}

int bar()
{
    int value = 0;

    printf("bar function called.\n");

    value = 1 / 0;

    printf("bar function returned.\n");

    return value;
}

int main()
{
  foo();

  return 0;
}
