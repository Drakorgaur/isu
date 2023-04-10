%include "rw32.inc"

CEXTERN malloc

; >> TASK:
; Naprogramujte funkci 'task23', která alokuje a naplni pole 16bitovych celych cisel bez znaménka Lucasovymi cisly
; L(0), L(1), . . . , L(N-1). Pozadovany pocet Lucasovych cisel je uveden v registru ECX (32bitova hodnota se znamenkem) 
; a funkce vraci v EAX ukazatel na pole, které alokuje funkci 'malloc' ez standardni knihovny jazyka C.

; LUC cisla:
; [0] = 2
; [1] = 0
; [n] = [n-2] + [n-1]
 

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
    
    mov ecx, 2
    push ecx
    
    call task23
    add esp, 4
    
    ; -== EOC == -
    pop ebp
    ret

task23:
; Vystup:
; AEX = 0, pokud N =< 0, nic nealokujete a vrátite hodnotu 0 (NULL),
; EAX = 0, pokud do$lo k chybe pri alokováni pamèti funkci malloci (vráti hodnotu 0),
; EAX = ukazatel na pole 16bitovch celodiselnych prvkù bez znaménka reprezentujicich Lucasova císla.  
    push ebp
    mov ebp, esp

    push esi
    push ebx
    push ecx
    push edx

    ; -== CODE == -
    cmp ecx, 0
    je .end
    
    mov ecx, [ebp + 8]

    push ecx
    call malloc
    pop ecx

    cmp eax, 0
    je .error

    mov esi, eax
    mov eax, ecx

    ; eax = pA
    mov word [esi], 2
    dec ecx
    jz .save_eax
    mov word [esi+2], 0
    dec ecx
    jz .save_eax

.for:
    mov edx, eax
    sub edx, ecx
    mov ebx, [esi + edx*2 - 4]
    add ebx, [esi + edx*2 - 2] 
    mov [esi + edx*2], ebx
    loop .for

.save_eax:
    mov eax, esi
    jmp .end


.error:
    mov eax, 0
    

.end:

    pop edx
    pop ecx
    pop ebx
    pop esi

    ; -== EOC == -
    pop ebp
    ret

