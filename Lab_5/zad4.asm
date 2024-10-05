format ELF64

public _start

include 'func.asm'

section '.bss' writable
buffer db 101

section '.text' executable
_start:
pop rcx
cmp rcx, 1
je .l1

mov rdi,[rsp+8] 
mov rax, 2 
mov rsi, 0o
syscall
cmp rax, 0
jl .l1
mov r8, rax 
mov rdi, [rsp+16]
mov rax, 2 
mov rsi, 1101o
syscall
cmp rax, 0
jl .l1
mov r9, rax

.loop_read: 
mov rax, 0 
mov rdi, r8 
mov rsi, buffer
mov rdx, 1
syscall
cmp rax, 0 
je .next
cmp byte [buffer], 'A'
je .loop_read 
cmp byte [buffer], 'E'
je .loop_read 
cmp byte [buffer], 'I'
je .loop_read 
cmp byte [buffer], 'O'
je .loop_read 
cmp byte [buffer], 'U'
je .loop_read 
cmp byte [buffer], 'Y'
je .loop_read 
mov rax, 1 
mov rdi, r9 
mov rsi, buffer
mov rdx, 1
syscall
jmp .loop_read 
.next: 
mov rdi, r8
mov rax, 3
syscall
mov rdi, r9
mov rax, 3
syscall
   
.l1:
call exit