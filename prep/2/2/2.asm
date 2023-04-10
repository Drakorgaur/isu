%include "rw32.inc"

; >> TASK:
; find min in array 32 unsigned
; use below

section .data
; >> db | dw | dd | dq <<
; >> 1b | 2b | 4b | 8b <<
    pa dd 100,2,3,1,4,5,6,7,10
    N dd 10

section .text

main:
    push ebp
    mov ebp, esp
    ; -== CODE == -
    xor eax, eax
    
    push dword [N]
    push pa

    call task22
    add esp, 8

    call WriteUInt32

    ; -== EOC == -
    pop ebp
    ret


task22: ;task22(const unsigned int *pA, int N)
; Return values:
; EAX= 0x80000000 if the pointer pA is invalid (pA==0) or N=< 0 EAX = value of the 32bit unsigned minimum

    push ebp
    mov ebp, esp
    ; -== CODE == -

    mov edx, [ebp+8]
    mov ecx, [ebp+12]
    mov eax, [edx]
    dec ecx

.for:
    cmp [edx + ecx*4], eax
    jb .min
    loop .for
    jmp .end

.min:
    mov eax, [edx + ecx*4]
    jmp .for
    
.end: 
    ; -== EOC == -
    pop ebp
    ret
