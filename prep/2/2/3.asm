%include "rw32.inc"

; >> TASK:
; Create a function: int task22(const unsigned char #pA, int N, unsigned char x) to count all occurrences of the values greater htan x 
; i n an array pA of N 8bit unsigned values.
; CDECL


section .data
; >> db | dw | dd | dq <<
  a db "1,2,113,4,5,6,7,10",0
  size_a equ $ - a
  b db ","

section .text

main:
    push ebp
    mov ebp, esp
    ; -== CODE == -
    push dword [b]
    push dword size_a
    push a

    call task22
    add esp, 12

    call WriteUInt32
    
    ; -== EOC == -
    pop ebp
    ret

task22: ;(const unsigned char #pA, int N, unsigned char )
    ; EAX = 1 if the pointer pA si invalid pA == 0 || N == 0
    
    push ebp
    mov ebp, esp
    ; -== CODE == -
    
    mov esi, [ebp + 8]  ; pA
    mov ecx, [ebp + 12] ; N
    mov edx, [ebp + 16] ; x

    xor eax, eax

    cmp byte [esi], 0
    je .error

    cmp ecx, 0
    je .error
    mov bl, dl ; bl = x | u_char 8
    dec ecx

.for:
    cmp bl, [esi + ecx*1]
    je .occurrence
    loop .for
    jmp .end

.occurrence:
    inc eax
    loop .for
    jmp .end

.error:
    mov eax, 1

.end:

    ; -== EOC == -
    pop ebp
    ret
