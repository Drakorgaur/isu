%include "rw32.inc"

; Task
; UNSIGNED x = (a^2 + b)^2
; a = u8bit
; b = u8bit
; x = u32bit

section .data
    a db 2
    b db 1
    x dd 0

section .text
main:
    push ebp
    mov ebp, esp

    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
;;;;; code here

    mov al, [a]
    mul al ; ax = a^2
    mov bx, ax ; bx = a^2
    mov al, [b]; al = b
    cwde ; ax = b
    add ax, bx ; ax = a^2+b = ax + bx

    mul ax ; dx:ax

    shl edx, 16
    mov dx, ax
    mov eax, edx

    call WriteUInt32
    call WriteNewLine

;;;;;
    pop ebp
    ret
