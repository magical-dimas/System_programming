format ELF64

public _start

include '/workspaces/System_programming/Lab_5/func.asm'

section '.text' executable
_start:
mov rsi, [rsp+16]
call str_number
mov rsi, rax
inc rsi
xor r8, r8
mov rcx, 1
.loop:
mov rax, rcx
call first_digit
mul rcx
add r8, rax
inc rcx
cmp rcx, rsi
jl .loop
mov rsi, output
mov rax, r8
call number_str
call print_str
call new_line
call exit

first_digit:
;rax = k, rax = res
mov rbx, 10
div_loop:
xor rdx, rdx
div rbx
cmp rax, 0
jg div_loop
mov rax, rdx
ret