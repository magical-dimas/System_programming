format ELF64

public _start

extrn initscr
extrn start_color
extrn init_pair
extrn getmaxx
extrn getmaxy
extrn raw
extrn noecho
extrn stdscr
extrn move
extrn getch
extrn addch
extrn refresh
extrn endwin
extrn exit
extrn timeout
extrn usleep
extrn curs_set
extrn erase

section '.bss' writable
max_x dq 1
max_y dq 1
palette dq 1
f db "/dev/random", 0
rand dq ?
buffer db ?

section '.text' executable
_start:
call initscr
mov rdi, [stdscr]
call getmaxx
dec rax
mov [max_x], rax
call getmaxy
dec rax
mov [max_y], rax
call start_color
mov rdi, 1
mov rsi, 2
mov rdx, 2
call init_pair
mov rdi, 2
mov rsi, 7
mov rdx, 7
call init_pair
call refresh
call noecho

mov rax, ' '
or rax, 0x100
mov [palette], rax

xor rdi, rdi
call curs_set
xor rdx, rdx

mov rax, 2
mov rdi, f
mov rsi, 0
syscall
mov [rand], rax

mov rbx, 2
mov rax, [max_x]
div rbx
mov r9, rax
mov rax, [max_y]
div rbx
mov r10, rax

moving:
mov rdi, r10
mov rsi, r9
push r9
push r10
call move
mov rdi, [palette]
call addch
call refresh
        
mov rax, 0 
mov rdi, [rand]
mov rsi, buffer
mov rdx, 1
syscall

pop r10
pop r9
xor rax, rax
xor rbx, rbx
xor rdx, rdx
mov al, [buffer]
mov rbx, 3
div rbx
add r9, rdx
dec r9
xor rdx, rdx
div rbx
add r10, rdx
dec r10
cmp r9, 0
jnl f1
add r9, 2
call color_change

f1:
cmp r9, [max_x]
jle f2
sub r9, 2
call color_change

f2:
cmp r10, 0
jnl f3
add r10, 2
call color_change

f3:
cmp r10, [max_y]
jle finish
sub r10, 2
call color_change

finish:
push r10
push r9
mov rdi, 50000
call usleep
call erase
pop r9
pop r10
jmp moving

finale:
call endwin
call exit

color_change:
mov rax, [palette]
and rax, 0x100
cmp rax, 0
jne .white
mov rax, [palette]
and rax, 0xff
or rax, 0x100
jmp @f
.white:
mov rax, [palette]
and rax, 0xff
or rax, 0x200
@@:
mov [palette], rax
ret