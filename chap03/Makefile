
.PHONY: all run
.SUFFIXES: .asm .bin

all: run

run: bochsrc.bxrc kernel.img
	bochs -q -f bochsrc.bxrc

kernel.img: boot.bin kernel.bin
	cat boot.bin kernel.bin > kernel.img

.asm.bin:
	nasm -f bin -o $@ $<


