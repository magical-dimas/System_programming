format ELF64

public _start
public exit
public print
public print_num

section '.bss' writable
n dq 3183775937
res dq 0
ten dq 10
output db 1

section '.text' executable
_start:
mov rax, [n]
xor rbx, rbx
.loop:
xor rdx, rdx
div qword [ten]
add rbx, rdx
cmp rax, 0
jne .loop

mov [res], rbx
call print_num
mov eax, 60
xor edi, edi
call exit

print:
mov [output], al
mov eax, 1
mov edi, 1
mov rsi, output
mov edx, 1
syscall
ret

print_num:
mov rax, [res]
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
add rax, '0'
call print
dec rbx
cmp rbx, 0
jne .print_loop

mov al, 0xA
call print
ret

exit:
mov eax, 1
mov ebx, 0
int 0x80