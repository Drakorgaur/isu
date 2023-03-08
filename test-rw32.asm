;**************************************************************
; Windows:
;	nasm -fobj test.asm
;	alink -oPE -subsys console test.obj
;
; Linux:
;	nasm -felf32 test.asm
;	gcc -m32 -o test test.o
;**************************************************************

%include 'rw32-2022.inc'

section .data
	STRING sMessage,"Hello World!",EOL

section .bss
	buffer resb 64

section .text
%define DEBUG
CMAIN:
	enter 0,0

	mov eax,'a'
        mov ebx,-100
        dbg_reg __LINE__,eax,ebx
	call WriteChar 
	call WriteNewLine

	mov esi,sMessage
	call WriteString
        dbg_reg __LINE__,al

    mov al,0xFF
    call WriteBin8
    call WriteNewLine

    mov ax,0xFFFF
    call WriteBin16
    call WriteNewLine

    mov eax,0xF0F0F0F0
    call WriteBin32
    call WriteNewLine

    mov al,1
    call WriteUInt8
    call WriteNewLine
    
    mov ax,1000
    call WriteUInt16
    call WriteNewLine
    
    mov eax,100000
    call WriteUInt32
    call WriteNewLine
  
    mov al,-1
    call WriteInt8
    call WriteNewLine
    
    mov ax,-1000
    call WriteInt16
    call WriteNewLine
    
    mov eax,-100000
    call WriteInt32
    call WriteNewLine

	mov eax,__float32__(5.55)
	call WriteFloat
	call WriteNewLine

	fldpi
	call WriteDouble
	call WriteNewLine
   
    call WriteFlags
	call WriteNewLine
	
	call ReadChar
	call WriteChar
	call WriteNewLine

	mov ebx,10
	mov edi,buffer
	call ReadString
	mov esi,buffer
	call WriteString
	call WriteNewLine

	call ReadInt8
	call WriteInt8
	call WriteNewLine

	call ReadInt16
	call WriteInt16
	call WriteNewLine

	call ReadInt32
	call WriteInt32
	call WriteNewLine
	
	call ReadUInt8
	call WriteUInt8
	call WriteNewLine

	call ReadUInt16
	call WriteUInt16
	call WriteNewLine

	call ReadUInt32
	call WriteUInt32
	call WriteNewLine

	call ReadFloat
	call WriteFloat
	call WriteNewLine

	call ReadDouble
	call WriteDouble
	call WriteNewLine

	mov eax,esp
	push eax
	sub eax,esp	
	pop ebx
	call WriteUInt32	
	call WriteNewLine	

	mov eax,esp
	push word 5
	sub eax,esp
	pop bx
	call WriteUInt32
	call WriteNewLine
	
	leave
	ret