format ELF64

public _start
public exit
public print

section '.bss' writable
array db 120 dup (':')
output db 1
count dq 0

section '.text' executable
_start:
xor rsi, rsi
.iterO:
xor rdi, rdi
mov rbx, [count]
inc rbx
mov [count], rbx
.iterI:
mov al, [array+rdi+rbx-1]
call print
inc rdi
cmp rdi, [count]
jne .iterI

mov al, 0xA
call print

inc rsi
cmp rsi, 15
jne .iterO
call exit

print:
push rax
mov [output], al
mov eax, 4
mov ebx, 1
mov ecx, output
mov edx, 1
int 0x80
pop rax
ret

exit:
mov eax, 1
mov ebx, 0
int 0x80