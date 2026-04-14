#include<stdio.h>
#include<strings.h>
#include<stdlib.h>
#include<dlfcn.h>

int main()
{
    char operation[100];
    int num1,num2;
    

    while(scanf("%s %d %d",operation,&num1,&num2)==3)
    {
        char nameing[100];
        sprintf(nameing,"./lib%s.so",operation);

        void *library=dlopen(nameing,RTLD_LAZY);

        int (*calcu)(int,int);
        calcu=(int(*)(int,int)) dlsym(library,"calculate");

        int final=calcu(num1,num2);
        printf("%d\n",final);

        dlclose(library);
    }
    return 0;
}