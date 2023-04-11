%include "rw32.inc"

; ISU 11.4.2023 [TEST 2] [Task 2]
;
;--- Task 2 ---
;
; Create a function: void* task22(const short *pA, int N, short x) to search an array pA of N 16bit signed
; values for the last occurrence of the value x. The function returns pointer to the value in the array.
; The parameters are passed, the stack is cleaned and the result is returned according to the PASCAL calling convention.
;
; Function parameters:
;   pA: pointer to the array A to search in
;    N: length of the array A
;    x: value to be searched for
;
; Return values:
;   EAX = 0 if the pointer pA is invalid (pA == 0) or N <= 0 or the value x has not been found in the array
;   EAX = pointer to the value x in the array (the array elements are indexed from 0)
;
; Important:
;   - the function MUST preserve content of all the registers except for the EAX and flags registers.
;


section .data

section .text

    a dw -1, -2, 4, -8 , 16, 99, 123, 155
    b dw 77
    c dw 8

main:
    push ebp
    mov ebp, esp
    ; -== CODE == -

    push a
    push word [c]
    push word [b]

    call task22
    ; cdecl
    ; add esp, n*4

    call WriteHex32
    
    ; -== EOC == -
    pop ebp
    ret

task22: ; void* task22(const short *pA, int N, short x)
    ; btw pointer to 1st element and error state are similar
    ; and tests dumped once and do not refreshing
    ; I was changing code and tests output were similar to 1st

    push ebp
    mov ebp, esp
    ; pascal convention left to right args

    push ebx
    push ecx
    push edx

    xor ebx, ebx
    xor ecx, ecx

    mov bx, [ebp + 8]  ;    x: value to be searched for
    mov ax, bx
    cwde
    mov ebx, eax

    mov cx, [ebp + 10] ;    N: length of the array A
    mov ax, cx
    cwde
    mov ecx, eax

    mov eax, [ebp + 12] ;   pA: pointer to the array A to search in

    cmp ecx, 0  ;   EAX = 0 if the pointer pA is invalid (pA == 0) or N <= 0 or the value x has not been found in the array
    jle .error

    cmp word [eax], 0  ;   EAX = 0 if the pointer pA is invalid (pA == 0) or N <= 0 or the value x has not been found in the array
    je .error

.for:
    cmp bx, [eax + ecx*2 - 2]
    je .found
    loop .for
    jmp .error

.found:
    mov eax, ecx
    mov ebx, 2
    mul ebx
    sub eax, 2
    jmp .end
.error:
    mov eax, 0 ;   EAX = 0 if the pointer pA is invalid (pA == 0) or N <= 0 or the value x has not been found in the array
.end:

    pop edx
    pop ecx
    pop ebx

    pop ebp
    ret 8 ; Pascal
