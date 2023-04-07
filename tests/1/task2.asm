%include "rw32.inc"

;
;--- Task 2 ---
;
; Create a function `task12` to evaluate the following expression using UNSIGNED integer arithmetic:
;
; q = (a*b + c + 25)/(6*d + e + 1106) ... division quotient
; r = (a*b + c + 25)%(6*d + e + 1106) ... division remainder
;
; The arguments a, b, c, d and e are stored in the memory and are defined as follows:
;
;    [a] ...  8bit unsigned integer
;    [b] ... 32bit unsigned integer
;    [c] ... 16bit unsigned integer
;    [d] ... 16bit unsigned integer
;    [e] ... 16bit unsigned integer
;
; Store the result to the memory at the addresses q and r this way:
;
;    [q] ... low 32 bits of the division quotient (32bit unsigned integer)
;    [r] ... division remainder (32bit unsigned integer)
;
; Important notes:
;  - do NOT take into account division by zero
;  - the function does not have to preserve the original content of the registers
;

section .data
;    [a] ...  8bit unsigned integer
;    [b] ... 32bit unsigned integer
;    [c] ... 16bit unsigned integer
;    [d] ... 16bit unsigned integer
;    [e] ... 16bit unsigned integer;
; ---------
;    [q] ... low 32 bits of the division quotient (32bit unsigned integer)
;    [r] ... division remainder (32bit unsigned integer)
; 10,20,10,7,7 == 0, 235
; 128,32768,32768,32768,32768

    a db 128
    b dd 32768
    c dw 32768
    d dw 32768
    e dw 32768

    q dd 0
    r dd 0

section .text
main:
    push ebp
    mov ebp, esp

; q = (a*b + c + 25)/(6*d + e + 1106) ... division quotient
; r = (a*b + c + 25)%(6*d + e + 1106) ... division remainder

;;;;; code
    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx

;;; (6*d + e + 1106)
;    [d] ... 16bit unsigned integer
;    [e] ... 16bit unsigned integer

    mov ax, [d]
    mov cx, 6
    mul cx ; ax:dx = ax*6
    shl edx, 16
    mov dx, ax ; edx = ax*6 = d*d

    xor eax, eax

    mov ax, word [e]

    add eax, edx ; (6*d + e)
    add eax, 1106 ; (6*d + e + 1106)

    mov ebx, eax ; ebx = (6*d + e + 1106)
;;; (a*b + c + 25)
;    [a] ...  8bit unsigned integer
;    [b] ... 32bit unsigned integer
;    [c] ... 16bit unsigned integer

    xor eax, eax
    xor edx, edx
    xor ecx, ecx

    mov al, [a] ; [a] ...  8bit unsigned integer dl = a
    mul dword [b] ; edx:eax = a*b

    mov ecx, eax
    xor eax, eax

    mov ax, [c]

    add ecx, eax
    adc edx, 0
    add ecx, 25
    adc edx, 0
    mov eax, ecx

    ;;; edx:eax = (a*b + c + 25)
    ;;; ebx = (6*d + e + 1106)
;;;;

;    [q] ... low 32 bits of the division quotient (32bit unsigned integer)
;    [r] ... division remainder (32bit unsigned integer)

    div ebx

    mov [q], eax
    mov [r], edx

;;; end

    pop ebp
    ret
