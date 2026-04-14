#include<stdio.h>
#include<strings.h>
#include<stdlib.h>
#include<dlfcn.h>

int main()
{
    char operation[100];
    int num1,num2;
    
    // read input until EOF
    while(scanf("%s %d %d",operation,&num1,&num2)==3)
    {
        char nameing[100];
        // build library name: lib<operation>.so
        sprintf(nameing,"./lib%s.so",operation);

        // load shared library
        void *library = dlopen(nameing,RTLD_LAZY);

        // get pointer to calculate function
        int (*calcu)(int,int);
        calcu = (int(*)(int,int)) dlsym(library,"calculate");

        // call function and print result
        int final = calcu(num1,num2);
        printf("%d\n",final);

        // free library
        dlclose(library);
    }
    return 0;
}