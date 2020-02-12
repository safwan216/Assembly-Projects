section .data
msg	db	'Hello World!', 0Ah, 00h

section .text

global _start

_start:
	push msg			;push the string to the stack
	call strlen			;call strlen function

	add esp, 4			;remove the argument from the stack

	mov edx, eax			;save the string length into edx
	pop eax				;restore eax

	mov eax, 4			;system call number for write
	mov ebx, 1			;file handle 1 is stdout
	mov ecx, msg			;number of bytes (1 per character)
	int 80h				;request an interrupt on libc using int 80h

exit:
	mov eax, 1			;syscam call number for exit
	mov ebx, 0			;return 0 status on exit - 'no errors'
	int 80h				;request an interrupt on libc using int 80h

strlen:
	push ebp			;save the old base pointer value
	mov ebp, esp			;set the new base pointer value
	sub esp, 4

	mov eax, [ebp+8]		;get the address of the first char
	mov [ebp-4], dword 0		;set the length of the string to 0
	cmp byte[eax], 0Ah		;check if the string is empty
	je finished			;reached end of the string

nextchar:
	inc eax				;increment the pointer to the next char
	add [ebp-4], dword 1		;increment the length of the string by 1
	cmp byte[eax], 0Ah		;check if the string is done
	jne nextchar			;if not keep looping through the string

finished:
	mov eax, [ebp-4]		;store the length of the string eax
	mov esp, ebp			;reset the stack pointer
	pop ebp				;restore the caller's base pointer
	ret				;return to where the function has been called
