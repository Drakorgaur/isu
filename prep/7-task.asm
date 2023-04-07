%include "rw32.inc"

; Task
; check if cislo je prvocislo

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

    call ReadUInt16
    ; ax = 1313
    mov bx, ax
    mov cx, ax
    dec bx

    cmp bx, 1
    je neni_prvocislo

for:
    cmp bx, 1
    je je_prvocislo

    mov ax, cx
    xor edx, edx
    div bx

    dec bx

    cmp dx, 0
    je neni_prvocislo

    jmp for


neni_prvocislo:

    mov esi, not_prvo

    jmp end

je_prvocislo:
    mov esi, yes_prvo

end:
    call WriteString

;;;;;
    pop ebp
    ret
