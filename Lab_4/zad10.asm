format ELF64

public _start
public read
public compare

include '/workspaces/System_programming/Lab_3/func.asm'

section '.bss' writable
input dq ?
output dq ?
password db "qwerty321", 0
success db "Вошли", 0
failure db "Неудача", 0
retry db "Неверный пароль", 0

section '.text' executable
_start:
mov rax, input
mov rdx, password
mov rsi, 5
.loop:
push rsi
call read
call compare
cmp rax, 1
je .suc
mov rsi, retry
call print_str
call new_line
pop rsi
dec rsi
cmp rsi, 0
jg .loop
mov rsi, failure
call print_str
call new_line
call exit
.suc:
mov rsi, success
call print_str
call new_line
call exit

read:
push rax
push rdi
push rsi
push rdx
mov rax, 0
mov rdi, 0
mov rsi, input
mov rdx, 255
syscall
pop rax
pop rdi
pop rsi
pop rdx
ret

compare:
mov rax, 0
ret