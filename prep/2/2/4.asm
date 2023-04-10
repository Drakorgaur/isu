%include "rw32.inc"

; >> TASK:
; 

section .data
; >> db | dw | dd | dq <<
; >> 1B | 2B | 3B | 4B <<
    a dw 1,2,3,4,5,6,7,10
    s dd 8
    b dw 6 ; x

section .text

main:
    push ebp
    mov ebp, esp
    ; -== CODE == -
    
    push dword [b]
    push dword [s]
    push a

    call task22

    add esp, 12

    call WriteUInt32

    ; -== EOC == -
    pop ebp
    ret

task22: ;task22(const unsigned char #pA, int N, unsigned char x) ; 16 bit unsigned
; Create a function: to count all occurrences of the values olwer than x 
; in an array pA of N 8bit unsigned values.
    push ebp
    mov ebp, esp
    ; -== CODE == -

    mov esi, [ebp + 8]
    mov ecx, [ebp + 12]
    mov edx, [ebp + 16]

    ; 16 bit
    cmp word [esi], 0
    je .error
    cmp ecx, 0
    je .error

    dec ecx
    xor eax, eax
    cmp dx, [esi]
    jb .for
    inc eax

.for:
    cmp dx, [esi + ecx*2]
    ja .occurrence
    loop .for
    jmp .end

.occurrence:
    inc eax
    loop .for
    jmp .end

.error:
    mov eax, -1

.end:
    ; -== EOC == -
    pop ebp
    ret