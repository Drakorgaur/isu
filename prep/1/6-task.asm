%include "rw32.inc"

; Task
; calculate UNSIGNED x = (( a + b ) * c - 42) / d 
; a = (unsigned int) 8 bit
; b = (unsigned int) 8 bit
; c = (unsigned int) 16 bit
; d = (unsigned int) 32 bit

section .data
    c dw 10
    d dd 2
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

    mov al, 3
    add al, 6

    mul word [c]

    shl edx, 16
    mov dx, ax
    mov eax, edx
    xor edx, edx

    sub eax, 42

    div dword [d]

    mov [x], eax

    call WriteInt32

;;;;;
    pop ebp
    ret
