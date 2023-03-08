obj:
	nasm -f elf32 -g -o $(f).o $(f).asm

# Path: Makefile
link:
	gcc -m32 -o $(f) $(f).o

# Path: Makefile
clean:
	rm -f $(f).o

# Path: Makefile
build: obj link clean

# Path: Makefile
run: build
	./$(f) | tee $(f).log
	echo exited with $?
