#include <stdio.h>
#include <stdlib.h>
int main(int argc, char* argv []){
    int a = atoi(argv[1]), b=atoi(argv[2]), c=atoi(argv[3]), res;
    //(((c+b)/c)-c)
    res = (((c+b)/c)-c);
    printf("%d\n", res);
    return 0;
}