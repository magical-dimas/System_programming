format ELF64

public _start

include '/workspaces/System_programming/Lab_5/func.asm'

section '.bss' writable
struc linux_dirent{
    .d_ino dq ?
    .d_off dq ?
    .d_reclen dq ?
    .d_name dq ?
}
f  db "/dev/urandom",0
number rq 1
unit_addr: times 100 dq ?
def_addr_len dq 0
files linux_dirent

section '.text' executable
_start:
mov rsi, [rsp+16]
xor rcx, -1
xor rbx, rbx
.reading:
inc rcx
mov bl, byte[rsi+rcx]
mov byte[unit_addr+rcx], bl
cmp byte[rsi+rcx], 0
jne .reading
mov byte[unit_addr+rcx], '/'
inc rcx
mov byte[unit_addr+rcx], 0
mov rdi, [rsp+16]
mov rax, 2
mov rsi, 65536
syscall
cmp rax, 0
je fin
mov r8, rax

mov rax, 78
mov rdi, r8
mov rsi, files
mov rdx, 300
syscall
mov r10, rax
mov rax, 2
mov rdi, f
mov rsi, 0o
syscall
cmp rax, 0
je fin
mov r9, rax

;старт
mov rbx, 18
;шаг
call rand_num
mov rcx, 32
mov rax, 0
mul rcx
add rbx, rax
mov rax, unit_addr
call len_str
mov rbx, 18
;mov rax, rbx
;div r10
;mov rbx, rdx
add rbx, files
xor rcx, rcx
mov r11, -1
.changing_path:
inc r11
mov cl, byte[rbx+r11]
add r11, rax
mov byte[unit_addr+r11], cl
sub r11, rax
cmp byte[rbx+r11], 0
jne .changing_path
mov rsi, unit_addr
call print_str
call new_line
call exit
call rand_chmod

;closing
mov rax, 3
mov rdi, r8
syscall
fin:
call exit

rand_num:
mov rax, 0
mov rdi, r9
mov rsi, number
mov rdx, 3
syscall
ret

rand_chmod:
push rcx
call rand_num
mov rax, [number]
mov rbx, 511
div rbx
mov rsi, rdx
mov rax, 90
mov rdi, unit_addr
syscall
pop rcx
ret