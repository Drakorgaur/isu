%include "rw32.inc"

; >> TASK:
; 

section .data
; >> db | dw | dd | dq <<
; >> 1B | 2B | 3B | 4B <<
;   a dq 1,2,3,4,5,6,7,10
;   b dq 10

section .text

main:
    push ebp
    mov ebp, esp
    ; -== CODE == -

    mov eax, 100   
    mov ecx, 1
    dec ecx
    jz .zero
    jmp .end

.zero:
    call WriteUInt32
.end
    
    ; -== EOC == -
    pop ebp
    ret
