%include "rw32.inc"

; Task
; SIGNED 
; a^3 = b^2 - 17
; a, b SIGNED 8 bit


section .data

section .text
main:
    push ebp
    mov ebp, esp

    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
;;;;; code here
    mov bl, -127 ; a

outer_for
    mov bh, -127 ; b

for:
    mov  al, bl
    cbw
    cwde
    mov edx, eax ; save convertion
    imul bl ; ax = a * a
    cwde
    imul edx ; edx:eax = a * a * a. do eax vejde v poho

    mov edx, eax

    xor eax, eax

    mov al, bh
    imul al ; ax = b * b
    sub ax, 17

    cwde ; eax = b^2 - 17

    cmp eax, edx
    je equal

    inc bh
    cmp bh, 127
    jne for

    inc bl 
    cmp bl, 127
    jne outer_for
    

    jmp end

equal:
    ; print bl && bh
    mov al, bl
    call WriteInt8
    mov al, 32
    call WriteChar
    mov al, bh
    call WriteInt8
    call WriteNewLine
    inc bh
    jmp for

end:

;;;;;
    pop ebp
    ret
