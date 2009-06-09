
.PHONY: all run

all: run

run: fd.img bochsrc.bxrc
	bochs -q -f bochsrc.bxrc


boot.bin: boot.asm
	nasm -f bin -o boot.bin boot.asm


