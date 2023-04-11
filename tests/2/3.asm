%include "rw32.inc"

; ISU 11.4.2023 [TEST 2] [Task 3]
;
;--- Task 3 ---
;
; Create a function 'task23' to allocate and fill an array of the 32bit unsigned elements by the
; Lucas numbers L(0), L(1), ... , L(N-1). Requested count of the Lucas numbers is
; in the register ECX (32bit signed integer) and the function returns a pointer to the array
; allocated using the 'malloc' function from the standard C library in the register EAX.
;
; Lucas numbers are defined as follows:
;
;   L(0) = 2
;   L(1) = 1
;   L(n) = L(n-1) + L(n-2)
;
; Function parameters:
;   ECX = requested count of the Lucas numbers (32bit signed integer).
;
; Return values:
;   EAX = 0, if ECX <= 0, do not allocate any memory and return value 0 (NULL),
;   EAX = 0, if memory allocation by the 'malloc' function fails ('malloc' returns 0),
;   EAX = pointer to the array of N 32bit unsigned integer elements of the Lucas sequence.
;
; Important:
;   - the function MUST preserve content of all the registers except for the EAX and flags registers,
;   - the 'malloc' function may change the content of the ECX and EDX registers.
;
; The 'malloc' function is defined as follows:
;
;   void* malloc(size_t N)
;     N: count of bytes to be allocated (32bit unsigned integer),
;     - in the EAX register it returns the pointer to the allocated memory,
;     - in the EAX register it returns 0 (NULL) in case of a memory allocation error,
;     - the function may change the content of the ECX and EDX registers.
;

CEXTERN malloc

section .data

section .text

main:
    push ebp
    mov ebp, esp
    ; -== CODE == -

    ; push
    ; push
    ; push
    mov ecx, 10
    call task23
    ; cdecl
    ; add esp, n*4

    call WriteUInt32
    
    ; -== EOC == -
    pop ebp
    ret

task23:
    push ebp
    mov ebp, esp
; Return values:
;   EAX = 0, if ECX <= 0, do not allocate any memory and return value 0 (NULL),
;   EAX = 0, if memory allocation by the 'malloc' function fails ('malloc' returns 0),
;   EAX = pointer to the array of N 32bit unsigned integer elements of the Lucas sequence.

    cmp ecx, 0
    jle .error

    push ebx
    push ecx
    push edx
    push esi

    mov eax, ecx
    mov ebx, 4
    mul ebx

    push ecx
    push eax
    call malloc ; mov eax, pointer_array
    pop ebx
    xor ebx, ebx
    pop ecx
    mov edx, ecx

    cmp eax, 0
    je .error

    mov esi, eax

    mov dword [esi], 2
    dec ecx
    jz .end

    mov dword [esi+4], 1
    dec ecx
    jz .end

.for:
    mov eax, edx
    sub eax, ecx
    mov ebx, [esi + eax*4 - 4]
    add ebx, [esi + eax*4 - 8]
    mov [esi+eax*4], ebx
    loop .for
    mov eax, esi
    jmp .end
    
.error:
    mov eax, 0

.end:

    pop esi
    pop edx
    pop ecx
    pop ebx
    
    pop ebp
    ret
