
.PHONY: all run clean
.SUFFIXES: .asm .bin

all: run

run: bochsrc.bxrc kernel.img
	bochs -q -f bochsrc.bxrc

kernel.img: boot.bin kernel.bin
	cat boot.bin kernel.bin > kernel.img

.asm.bin: init.inc
	nasm -f bin -o $@ $<

clean:
	rm -f *.bin *.img bochsout.txt
