%include "init.inc"
[org 0]

	jmp	0x07C0:start	; far jump?

start:
	mov	ax, cs		; 0x07C0 in cs
	mov	ds, ax
	mov	es, ax

	mov	ax, 0xB800	; segment addr of video memory
	mov	es, ax
	mov	di, 0
	mov	ax, word [msgBack]
	mov 	cx, 0x7ff

paint:
	mov	word [es:di], ax
	add	di, 2
	dec	cx
	jnz	paint

read:
	mov	ax, 0x1000
	mov	es, ax
	mov	bx, 0
	
	mov	ah, 2
	mov	al, 1
	mov	ch, 0
	mov	cl, 2
	mov	dh, 0
	mov	dl, 0
	int	0x13

	jc	read

	cli			;clear interrupt flag

	lgdt	[gdtr]		;load global/interrupt descriptor table

	mov	eax, cr0
	or	eax, 0x00000001
	mov	cr0, eax

	jmp $+3		;flush pipeline
	nop
	nop

	mov	bx, SysDataSelector
	mov	ds, bx
	mov	es, bx
	mov	fs, bx
	mov	gs, bx
	mov	ss, bx
	
;; 	db	0x66
;; 	db	0x67
;; 	db	0xEA
;; 	dd	PM_Start
;; 	dw	SysCodeSelector

	jmp	dword SysCodeSelector:0x0000

msgBack	db	' ', 0x67

	
gdtr:
	dw	gdt_end - gdt - 1
	dd	gdt+0x7C00

gdt:
	;; null segment discriptor
	dw	0
	dw	0
	db	0
	db	0
	db	0
	db	0

	;; system code segment discriptor
	dw	0xffff
	dw	0x0000
	db	0x01
	db	0x9a
	db	0xcf
	db	0x00

	;; system data segment discriptor
	dw	0xffff
	dw	0x0000
	db	0x01
	db	0x92
	db	0xcf
	db	0x00

	;; video segment discriptor
	dw	0xFFFF
	dw	0x8000
	db	0x0b
	db	0x92
	db	0x40
	db	0x00
gdt_end:

times	510-($-$$)	db	0
	dw	0xAA55
	