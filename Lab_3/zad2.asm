format ELF64

public _start
public print
public print_num

include 'func.asm'

section '.bss' writable
a dq ?
b dq ?
c dq ?
output dq ?

section '.text' executable
_start:
mov rsi, [rsp+16]
call str_number
mov [a], rax
mov rsi, [rsp+24]
call str_number
mov [b], rax
mov rsi, [rsp+32]
call str_number
mov [c], rax
mov rax, [c]
add rax, [b]
mov rbx, [c]
test rbx, rbx
jns fl1
neg [c]
mov r8, 1
fl1:
div [c]
cmp r8, 1
jne fl2
neg [c]
neg rax
fl2:
sub rax, [c]
call print_num
call new_line
call exit

;(((c+b)/c)-c)

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
test rax, rax
jns .loop
push rax
mov rax, '-'
call print
pop rax
neg rax

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