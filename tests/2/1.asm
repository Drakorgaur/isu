%include "rw32.inc"

; ISU 11.4.2023 [TEST 2] [Task 1]

;--- Task 1 ---
;
; Create a function 'task21' to find if there is a value in an array of the 32bit signed values.
; Pointer to the array is in the register EAX, the value to be found is in the register EBX
; and the count of the elements of the array is in the register ECX.
;
; Function parameters:
;   EAX = pointer to the array of the 32bit signed values (EAX is always a valid pointer)
;   EBX = 32bit signed value to be found
;   ECX = count of the elements of the array (ECX is an unsigned 32bit value, always greater than 0)
;
; Return values:
;   EAX = 1, if the value has been found in the array, otherwise EAX = 0
;
; Important:
;   - the function does not have to preserve content of any register
;


section .data

    a dd -71

section .text

main:
    push ebp
    mov ebp, esp
    ; -== CODE == -

    mov eax, a
    mov ebx, -71
    mov ecx, 1

    call task21

    call WriteUInt32
    
    ; -== EOC == -
    pop ebp
    ret

task21:
    push ebp
    mov ebp, esp

    cmp ecx, 0
    je .end

.for:
    cmp ebx, [eax + ecx*4 - 4]
    je .found
    loop .for
    mov eax, 0
    jmp .end

.found: 
    mov eax, 1

.end:
    
    pop ebp
    ret
