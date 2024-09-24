format ELF64

public _start
public exit
public print

section '.bss' writable
array db 120 dup (':')
output db 1

section '.text' executable
_start:
xor rsi, rsi
.iterO:
xor rdi, rdi
.iterI:
mov al, [array+rdi+rsi*8]
push rdi
call print
pop rdi
inc rdi
cmp rdi, 8
jne .iterI

mov al, 0xA
push rsi
call print
pop rsi

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