#include <stdio.h>
int main(){
    long n = 3183775937;
    char sum = 0;
    for(; n > 0; n /= 10) sum += n%10;
    printf("%d\n", sum);
    return 0;
}