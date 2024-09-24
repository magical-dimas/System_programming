format ELF64

public _start
public print
public print_num

include 'func.asm'

section '.bss' writable
output dq ?

section '.text' executable
_start:
mov rsi, [rsp+16]
mov al, byte [rsi]
mov rsi, output
call print_num
call new_line
call exit

print:
mov [output], rax
mov eax, 1
mov edi, 1
mov rsi, output
mov edx, 1
syscall
ret

print_num:
xor rbx, rbx
mov rcx, 10

.loop:
xor rdx, rdx
div rcx
push rdx
inc rbx
cmp rax, 0
jne .loop

.print_loop:
pop rax
add rax, 48
call print
dec rbx
cmp rbx, 0
jne .print_loop
ret