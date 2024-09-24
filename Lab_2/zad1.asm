format ELF64
public _start
public exit
public print

section '.data'
s db "SOobDTGStDqTdPgjZTOPTmGpgGp"

section '.bss' writable
output db 1

section '.text' executable
_start:
mov rcx, 26

.iter:
mov al, [s+rcx]
push rcx
call print
pop rcx
dec rcx
cmp rcx, -1
jne .iter

mov al, 0xA
call print
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