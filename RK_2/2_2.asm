format elf64

public _start

extrn usleep

include "func.asm"

section '.data' writable
msg db "Hi, I am process number ", 0
buffer db 0
pid1 dq 1
pid2 dq 1
	
section '.text' executable	
_start:
pop rax
cmp rax, 2
jl finale
mov rsi, [rsp+8]
call str_number
push rax
mov rax, 57
syscall
pop r8
cmp rax, 0
je child
mov [pid1], rax
mov rax, 62
mov rsi, 19
mov rdi, [pid1]
syscall
mov rax, 57
syscall
cmp rax, 0
je child
mov [pid2], rax
mov rax, 62
mov rsi, 19
mov rdi, [pid2]
syscall
jmp parent

child:
mov rsi, msg
call print_str
mov rax, 39
syscall
mov rsi, buffer
call number_str
call print_str
call new_line
mov rdi, 10
call usleep
dec r8
cmp r8, 0
jne child
call exit

parent:
mov rax, 62
mov rsi, 18
mov rdi, [pid1]
syscall
mov rdi, 1
call usleep
mov rax, 62
mov rsi, 19
mov rdi, [pid1]
syscall
mov rax, 62
mov rsi, 18
mov rdi, [pid2]
syscall
mov rdi, 1
call usleep
mov rax, 62
mov rsi, 19
mov rdi, [pid2]
syscall
dec r8
cmp r8, 0
jne parent
finale:
call exit