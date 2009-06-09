
.PHONY: all run

all: run

run: bochsrc.bxrc boot.bin
	bochs -q -f bochsrc.bxrc

boot.bin: boot.asm
	nasm -f bin -o boot.bin boot.asm


