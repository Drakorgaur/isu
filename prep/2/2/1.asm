%include "rw32.inc"

; >> TASK:
; find in array 8 signed bit[] value
; Returns:
; EAX = 0:
;   - pa == 0
;   - N < 0
;   - not found
; EAX = index of item


section .data
; >> db | dw | dd | dq <<
    pa db 1,-2,3,10,4,5,-6,7,-10
    b dq -10
    N dq 9

section .text

main:
    push ebp
    mov ebp, esp
    ; -== CODE == -
    

    push dword [b]
    push dword [N]
    push dword pa

    call task22
    add esp, 12
    
    call WriteUInt32

    ; -== EOC == -
    pop ebp
    ret

task22: ;void* (const char *, int N, char)
    push ebp
    mov ebp, esp
    ; -== CODE == -
    
    ;; read args
    mov esi, [ebp+8] ; array
    mov ecx, [ebp+12] ; number of elements
    mov edx, [ebp+16] ; search for

    ; mov 8 low bits to bl
    mov bl, dl ; bl - we search for
    mov edx, ecx

    cmp byte [esi], 0
    je .error

    cmp ecx, 0
    je .error

.for:
    mov eax, edx
    sub eax, ecx
    cmp [esi + eax], bl
    je .end
    loop .for

.error:
    mov eax, 0

.end:

    ; -== EOC == -
    pop ebp
    ret
