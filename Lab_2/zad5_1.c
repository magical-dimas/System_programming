#include <stdio.h>

int main(){
    long long n = 3183775937;
    int sum = 0;
    while(n>0){
        sum += n%10;
        n /= 10;
    }
    printf("%d\n", sum);
    return 0;
}