format ELF64
public _start
msg db "Bikmatov", 0xA, "Dmitriy", 0xA, "Andreevich", 0xA, 0

_start:
    mov rax, 4
    mov rbx, 1
    mov rcx, msg
    mov rdx, 29
    int 0x80
    mov rax, 1
    mov rbx, 0
    int 0x80