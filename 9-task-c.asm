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
    ;a,b,c,d 
    mov bh, -127 ; a
    mov bl, -127 ; b

outer_for:
    mov bl, -127

for:
    xor eax, eax
    xor edx, edx

    mov al, bh ; a
    cbw ; ax = a
    mov dx, ax ; dx = a
    
    xor eax, eax ; eax = null

    mov al, bh ; al = eax = a
    imul al ; ax = al^2 = a^2

    imul dx; dx:ax = ax*dx = a^2 * a

    shl edx, 16
    mov dx, ax
    ;; edx = a^3
    xor eax, eax

    mov al, bl ; al = b
    imul al ; ax = b ^ 2

    sub ax, 17 ; ax = b^2 - 17
    cwde ; eax = b^2 - 17

    cmp eax, edx
    je equal

    inc bl
    cmp bl, -127
    jne for

    inc bh
    cmp bh, -127
    jne outer_for

    jmp end

equal:
    mov al, bh ; a
    call WriteInt8
    mov eax, 32
    call WriteChar
    mov al, bl 
    call WriteInt8 ; b

    call WriteNewLine

    inc bl

    jmp for
end: 

;;;;;
    pop ebp
    ret

; -2 -3
; -2 3
; -1 -4
; -1 4
; 2 -5
; 2 5
; 4 -9
; 4 9
; 8 -23
; 8 23
