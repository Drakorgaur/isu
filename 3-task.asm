%include "rw32.inc"

; Task
; reverse 8bit numbers

section .data

section .text
main:
    push ebp
    mov ebp, esp

    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx

    mov al, 11110011b
    mov ecx, 8
.for:
    shr al, 1
    rcl bl, 1
    loop .for

    mov eax, ebx

    pop ebp
    ret
