#include <stdio.h>
#include <stdlib.h>

char* foo();


char* foo() 
{
    char* ptr = NULL;

    printf("foo function called.\n");

    ptr = malloc(1024);

    printf("----.\n");
    printf("----.\n");
    printf("----.\n");

    free(ptr);
    
    printf("foo function returned.\n");

    return ptr;
}

int main()
{
  char* ptr = NULL;
  
  ptr = foo();

  free(ptr);

  return 0;
}
