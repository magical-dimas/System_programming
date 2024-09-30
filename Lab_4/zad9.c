#include <stdio.h>
#include <stdlib.h>

int main(){
    int n, res = 0;
    scanf("%d",&n);
    for (int i = 1; i <= n; i++)
    if (i%4 == 1 || i%4 == 2)
        res += i;
    else
        res -= i;
    printf("%d\n", res);
    return 0;
}