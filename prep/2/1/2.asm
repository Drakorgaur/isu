%include "rw32.inc"

; find value in array

section .data

    a dq 1,2,3,4,5,6,7,10
    b dq 10
    ; c size of a
    c dq 7

section .text

main:
    push ebp
    mov ebp, esp

    mov eax, a
    mov ebx, [b]
    mov ecx, [c]

    call task21

    call WriteUInt32

    pop ebp
    ret

task21:
    ; find in array 
    ; int* a, int*b, int size

    push ebp
    mov ebp, esp

for:

    mov edx, [eax + ecx*8]
    cmp ebx, edx
    je found

    loop for
    mov eax, 0
    jmp end

found:
    mov eax, 1

end:

    pop ebp
    ret