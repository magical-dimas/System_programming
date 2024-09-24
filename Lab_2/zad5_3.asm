format ELF64

public _start
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
test rax, rax
jnz .loop

mov [res], rbx
call print_num
mov eax, 60
xor edi, edi
syscall

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
mov rdi, 10

.loop:
xor rdx, rdx
div rdi
push rdx
inc rbx
test rax, rax
jnz .loop

.print_loop:
pop rax
add rax, '0'
call print
dec rbx
jnz .print_loop

mov al, 0xA
call print
ret