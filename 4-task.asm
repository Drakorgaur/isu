%include "rw32.inc"

; Task
; role registr EAX = XD XC XB XA => EAX = XA XB XC XD

section .data

section .text
main:
    push ebp
    mov ebp, esp

    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
;;;;; code here

    mov eax, 0xDDCCBBAA

    rol ax, 8
    rol eax, 16
    rol ax, 8

;;;;;
    pop ebp
    ret
