format ELF
public _start
msg db "Bikmatov", 0xA, "Dmitriy", 0xA, "Andreevich", 0xA, 0

_start:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg
    mov edx, 29
    int 0x80
    mov eax, 1
    mov ebx, 0
    int 0x80