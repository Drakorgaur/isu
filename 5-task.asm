%include "rw32.inc"

; Task
; calculate signed x = (( a + b ) * c - 42) / d 
; a = (signed int) 8 bit
; b = (signed int) 8 bit
; c = (signed int) 16 bit
; d = (signed int) 32 bit

section .data
    c dw -10
    d dd 4
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
    add al, -6

    cbw

    imul word [c]
    shl edx, 16
    mov dx, ax
    mov eax, edx

    sub eax, 42

    cdq

    idiv dword [d]
    mov [x], eax

    call WriteInt32

;;;;;
    pop ebp
    ret
