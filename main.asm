%include "rw32.inc"

section .data
    pole_1 dw 1,2,3,-420,5,6,7,8
    pole_2 dd 1,2,3,0,5,6,7,8

section .text
main:
    push ebp
    mov ebp, esp

    mov ax, [pole_1 + 3*2]
    add ax, [pole_1 + 5*2]
    cwde

    mov [pole_2 + 3*4], eax

    call WriteInt32

    pop ebp
    ret
