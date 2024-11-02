#include "stdio.h"

void new_queue();

void del_queue();

long get_size();

void q_push(long);

long q_pop();

void rand_fill(long);

void del_even();

long count_simple();

long count_ones();


int main(){
    new_queue();
    rand_fill(10);
    long el = 999;
    for (; el < 1004; el++) q_push(el);

    long simple = count_simple(), end_ones = count_ones();
    printf("простых: %ld, оканчиваются на 1: %ld\n", simple, end_ones);
    printf("Очередь имеет вид:\n");
    for (int i = 0; i < get_size(); i++){
        el = q_pop();
        printf("%ld\n", el);
        q_push(el);
    }
    del_even();
    printf("После удаления чётных очередь имеет вид:\n");
    for (int i = 0; i < get_size(); i++){
        el = q_pop();
        printf("%ld\n", el);
        q_push(el);
    }
    del_queue();
    return 0;    
}