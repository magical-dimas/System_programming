asm: queue.asm
		fasm queue.asm

c: asm prog.c
		gcc -no-pie prog.c queue.o -o test

run: c test
		./test

clean:
		rm -f *.o