%include "rw32.inc"

; Task
; check if cislo je prvocislo
; unsigned 16

section .data
    not_prvo db "Neni prvocislo", 0
    yes_prvo db "Je prvocislo", 0

section .text
main:
    push ebp
    mov ebp, esp

    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
;;;;; code here

    call ReadUInt16 ; ax = <some>
    mov bx, ax
    mov cx, ax
    dec bx
for:
    xor eax, eax
    mov ax, cx
    cmp bx, 1
    je prvocislo

    xor edx, edx
    div bx ; dx:ax = ax/bx
    dec bx

    cmp dx, 0
    je neni_prvocislo

    jmp for

prvocislo:
    mov esi, yes_prvo
    jmp end

neni_prvocislo:
    mov esi, not_prvo

end:
    call WriteString
    call WriteNewLine

;;;;;
    pop ebp
    ret
