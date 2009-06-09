[org 0]
[bits 16]
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


	;; print prompt
	mov	bh, 0
	mov	dh, 0
	mov	dl, 0
	lea	ax, [msgContinue]
	mov	si, ax

print_loop:
	;; set cursor
	mov	ah, 0x02
	int	0x10
	
	mov	al, byte [si]
	or	al, al
	jz	keyboard
	mov	ah, 0x09
	mov	bh, 0
	mov	bl, 0x06
	mov	cx, 1
	int	0x10
	inc	si
	inc	dl
	jmp	print_loop

keyboard:
	xor	ah, ah
	int	0x16

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

	jmp	0x1000:0000

msgBack	db	' ', 0x67
msgContinue	db	"Press any key to continue", 0

times	510-($-$$)	db	0
	dw	0xAA55
	