%include "rw32.inc"

; check arrays are same

section .data

    a dq 1,2,3,4,5,6,7
    b dq 1,2,3,4,9,6,7
    ; c size of a
    c dq 7

section .text

main:
    push ebp
    mov ebp, esp

    mov eax, a
    mov ebx, b
    mov ecx, [c]

    call task21

    call WriteUInt32

    pop ebp
    ret

task21:
    ; compare 2 arrays of 32 unsigned int
    ; int* a, int*b, int size

    push ebp
    mov ebp, esp

for:
    mov edx, [eax + ecx*8]

    cmp edx, [ebx + ecx*8]
    jne unequal

    loop for
    mov eax, 1
    jmp end

unequal:
    mov eax, 0

end:

    pop ebp
    ret