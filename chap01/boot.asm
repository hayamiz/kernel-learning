[org 0]
[bits 16]
	jmp	0x07C0:start	; far jump?

start:
	mov	ax, cs		; 0x07C0 in cs
	mov	ds, ax

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

	mov	edi, 0
	mov	byte [es:di], 'H'
	inc	edi
	mov	byte [es:di], 0x06
	inc	edi
	mov	byte [es:di], 'e'
	inc	edi
	mov	byte [es:di], 0x06
	inc	edi
	mov	byte [es:di], 'l'
	inc	edi
	mov	byte [es:di], 0x06
	inc	edi
	mov	byte [es:di], 'l'
	inc	edi
	mov	byte [es:di], 0x06
	inc	edi
	mov	byte [es:di], 'o'
	inc	edi
	mov	byte [es:di], 0x06
	inc	edi
	mov	byte [es:di], ','
	inc	edi

	mov	byte [es:di], 0x06
	inc	edi
	mov	byte [es:di], ' '
	inc	edi
	mov	byte [es:di], 0x06
	inc	edi
	mov	byte [es:di], 'w'
	inc	edi
	mov	byte [es:di], 0x06
	inc	edi
	mov	byte [es:di], 'o'
	inc	edi
	mov	byte [es:di], 0x06
	inc	edi
	mov	byte [es:di], 'r'
	inc	edi
	mov	byte [es:di], 0x06
	inc	edi
	mov	byte [es:di], 'l'
	inc	edi
	mov	byte [es:di], 0x06
	inc	edi
	mov	byte [es:di], 'd'
	inc	edi
	mov	byte [es:di], 0x06

	jmp 	$

msgBack	db	'.', 0xE7

times	510-($-$$)	db	0
	dw	0xAA55
	