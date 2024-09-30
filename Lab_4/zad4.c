#include <stdio.h>
#include <stdlib.h>

int main(){
    int n, res = 0;
    scanf("%d",&n);
    for (int i = 1; i <= n; i++)
    if (i%2 == 0)
        res += i*(i+4)*(i+8);
    else
        res -= i*(i+4)*(i+8);
    printf("%d\n", res);
    return 0;
}