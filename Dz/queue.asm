format ELF64

public new_queue
public del_queue
public q_push
public q_pop
public rand_fill
public del_even
public count_simple
public count_ones
public get_size

section '.bss' writable
head rq 1
tail rq 1
num rb 1
size rq 1
f db "/dev/random", 0

section '.text' executable

new_queue:
xor rdi,rdi
mov rax, 12
syscall
mov [head], rax
mov [tail], rax
ret

del_queue:
.loop:
mov rax, [head]
cmp rax, [tail]
jge .fin
call q_pop
jmp .loop
.fin:
ret

q_push:
push rdi
mov rdi, [tail]
add rdi, 8
mov rax, 12
syscall
mov [tail], rax
pop rdi
sub rax, 8
mov [rax], rdi
inc [size]
ret

q_pop:
mov rax, [head]
cmp rax, [tail]
jge .fin
mov r8, [rax]
push r8
;сдвигаем всё к началу
mov rdx, rax
add rdx, 8
.loop:
mov rsi, [rdx]
mov [rax], rsi
add rax, 8
add rdx, 8
cmp rax, [tail]
jl .loop
mov rdi, [tail]
sub rdi, 8
mov rax, 12
syscall
mov [tail], rax
.fin:
dec [size]
pop r8
mov rax, r8
ret

rand_fill:
;rdi - count
mov r8, rdi
imul r8, 8
add r8, [tail]
mov rax, 2
mov rdi, f
mov rsi, 0o
syscall 
mov r9, rax
.loop:
cmp r8, [tail]
je .fin
mov rax, 0
mov rdi, r9
mov rsi, num
mov rdx, 1
syscall
xor rax, rax
xor rdi, rdi
mov al, byte[rsi]
add rdi, rax
call q_push    
jmp .loop
.fin:
mov rax, 3
mov rdi, r9
syscall
ret

del_even:
xor r9, r9
.loop:
mov rsi, [head]
mov rax, [rsi]
mov r8, 2
div r8
cmp rdx, 0
je .fl
mov rdi, [rsi]
call q_push
.fl:
call q_pop
inc r9
mov rsi, [head]
mov rax, [rsi]
mov r8, 2
div r8
ret
cmp rdx, 0
je .fl1
mov rdi, [rsi]
call q_push
.fl1:
call q_pop
inc r9
cmp r9, [size]
;jl .loop
ret

count_simple:
xor r8, r8
mov r9, [head]
.loop:
cmp r9, [tail]
jge .fin
mov rdi, [r9]
call simple_check
add r9, 8
cmp rax, 1
jne .loop
inc r8
jmp .loop
.fin:
mov rax, r8
ret

simple_check:
push r8
push r9
mov rax, 1
cmp rdi, 2
jnl .f
.nf:
xor rax, rax
jmp .fin
.f:
mov r8, 2
mov r9, rdi
.loop:
cmp r8, r9
je .fin
xor rdx, rdx
push rax
mov rax, r9
div r8
pop rax
cmp rdx, 0
je .nf
inc r8
jmp .loop   
.fin:
pop r9
pop r8
ret

count_ones:
xor r8, r8
mov r9, [head]
.loop:
cmp r9, [tail]
jge .fin
xor rdx, rdx
mov rax, [r9]
mov rdi, 10
div rdi
add r9, 8
cmp rdx, 1
jne .loop
inc r8
jmp .loop
.fin:
mov rax, r8
ret

get_size:
mov rax, [size]
ret