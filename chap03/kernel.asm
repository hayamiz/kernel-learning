%include "init.inc"

[org 0]
[bits 32]

PM_Start:
	jmp $
	mov	bx, SysDataSelector
	mov	ds, bx
	mov	es, bx
	mov	fs, bx
	mov	gs, bx
	mov	ss, bx

	xor	eax, eax
	mov	ax, VideoSelector
	mov	es, ax
	mov	edi, 80*2*10+2*10
	lea	esi, [ds:msgPMode]
	call	printf

	jmp	$

	;; Subroutines

printf:
	push eax

printf_loop:
	or	al, al
	jz	printf_end
	mov	al, byte [esi]
	mov	byte [es:edi], al
	inc	edi
	mov	byte [es:edi], 0x06
	inc	esi
	inc	edi
	jmp	printf_loop

printf_end:
	pop	eax
	ret

msgPMode	db	"We are in Protected Mode", 0

	;; GDT Table
