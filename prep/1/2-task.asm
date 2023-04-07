%include "rw32.inc"

; Task
; Read Uint16 to AX. pocet bit 1 v AX

section .data

section .text
main:
    push ebp
    mov ebp, esp

    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx

    call ReadUInt16
    mov ecx, 17

.for:
    dec ecx
    cmp ecx, 0
    je .end

    shr ax, 1
    jnc .for
    inc ebx
    jmp .for
.end:

    mov eax, ebx
    call WriteUInt32
    call WriteNewLine

    pop ebp
    ret
