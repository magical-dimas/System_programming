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

section '.bss' writable
max_x dq 1
max_y dq 1
palette dq 1
delay dq ?
speed_mode dq 1

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
call raw

mov rax, ' '
or rax, 0x100
mov [palette], rax

mov [delay], 100
mov [speed_mode], 1
xor r8, r8

.outer_loop:
xor r9, r9
.inner_loop:
mov rdi, r8
mov rsi, r9
push r8
push r9
call move

mov rdi, [palette]
call addch
call refresh

mov rdi, 1
call timeout
call getch
cmp rax, 'z'
jne .check_haste
jmp .fin

.check_haste:
cmp rax, 'h'
jne .skip
.fast:
cmp [speed_mode], 1
jne .slow
cmp [delay], 100
jng .slow
mov [delay], 100
.slow:
mov [speed_mode], 0
cmp [delay], 12600
jnl .ch_mode
add [delay], 2500
jmp .skip

.ch_mode:
mov [speed_mode], 1
jmp .fast

.skip:
xor rdi, rdi
mov rdi, [delay]
call usleep
pop r9
pop r8
inc r9
cmp r9, [max_x]
jng .inner_loop
inc r8
cmp r8, [max_y]
jng .outer_loop

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
xor r8, r8
jmp .outer_loop

.fin:
call endwin
call exit