	global	_start
	section	.text
_start: mov	eax, 4		;system call number for write
	mov	ebx, 1		;file handle 1 is stdout
	mov	ecx, message	;address of string in output
	mov	edx, 29		;number of bytes (1 per character)
	int 80h			;request an interupt on libc using int 80h
exit:	mov	eax, 1		;syscam call number for exit
	mov	ebx, 0		;return 0 status on exit - 'no errors'
	int 80h			;request an interupt on libc using int 80h

	section	.data
message:db	"Safwan Shahid, 23357863, CC1", 0Ah
