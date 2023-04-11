# Help
This is useful to read before starting with VSCode as assebly IDE for ISU.

also before you go bomb your PC with assembly code, make sure you've read:
- [VScode configuration](https://moodle.vut.cz/mod/book/view.php?id=217391&chapterid=13407)
- [ISU Mac M1](https://moodle.vut.cz/mod/book/view.php?id=217391&chapterid=13419)

Last article is not the best because, imho the easiest way to run virtual is [colima](https://github.com/abiosoft/colima) with docker. Using colima directly is not possible because Colima uses Alphine as OS, that VSCode remote is not supporting.

*Note: this repo was created to be used for mac m1*
*on linux you should not have any problems with it anyway.*  
*There is installed copilot in .devcontainer, only for STUDING, noway use it on test.*

# How to run
Copy template.asm to the root folder of repo(same directory where template is).
build/debug.  
For build/debugging are used Fog's configuration for VSCode(they are not the best, may be in future they could be improved) 

# Debug statements / GDB
### Debug console
Debug console requires using `-exec` flag before execution statement.

```bash
# to print array of integers that is stored in variable
-exec print (short int[10])pole_1

# to print array that stored in standard register
-exec print (short int[10])*$eax

# to print BYTE integeres (see below for types)
-exec print/d ((char[9])*$eax)
```


*for windowed explorer you can use it without `-exec`*

## C types to Assembly types
| C type        | Assembly type |
|---------------|---------------|
| unsigned char | db            |
| short int     | dw            |
| int           | dd            |
| long int      | dq            |

explanation in lldb(apple's analog for gdb):
```C
(lldb) p/d sizeof(unsigned char)
(unsigned long) $4 = 1
        
(lldb) p/d sizeof(short int)
(unsigned long) $5 = 2
        
(lldb) p/d sizeof(int)
(unsigned long) $6 = 4
        
(lldb) p/d sizeof(long int)
(unsigned long) $7 = 8
```
*`p/d` is print %d (what means print integer if possible)*

# Notes about ISU

## Registers
### General purpose registers
| Register | Description   |
|----------|---------------|
| EAX      | Accumulator   |
| EBX      | Base          |
| ECX      | Counter       |
| EDX      | Data          |
| ESI      | Source        |
| EDI      | Destination   |
| EBP      | Base Pointer  |
| ESP      | Stack Pointer |


### EAX
|  .  |  .  |  ax   |  
|:---:|:---:|:-----:|
|  .  |  .  | ah/al |


|  .  |  .  |  .  |  .  |
|:---:|:---:|:---:|:---:|
|  .  |  .  | ah  | al  |

# Converting
```asm
; cbw
mov al, -8
cbw ; creates AX = -8

; cwd
mov ax, -8
cwd ; creates DX:AX = -8, which means dx will be 0xFFFF and ax will be 0xFFF8

; cwde
mov ax, -8
cwde ; creates EAX = -8

; cdq
mov eax, -8
cdq ; creates EDX:EAX = -8
```


## JUMPS
### Common
| Instruction | Description              |
|-------------|--------------------------|
| JZ          | Jump if zero             |
| JNZ         | Jump if not zero         |
| JG          | Jump if greater          |
| JGE         | Jump if greater or equal |
| JL          | Jump if less             |
| JLE         | Jump if less or equal    |
| JC          | Jump if carry            |
    

### Jumps without sign
| Instruction | Description              |
|-------------|--------------------------|
| JA          | Jump if above            |
| JAE         | Jump if above or equal   |
| JB          | Jump if below            |
| JBE         | Jump if below or equal   |

### Jumps with sign
| Instruction | Description              |
|-------------|--------------------------|
| JG          | Jump if greater          |
| JGE         | Jump if greater or equal |
| JL          | Jump if less             |
| JLE         | Jump if less or equal    |


## Function calling convention

| Name      | Parameters    | Cleanup  | Name mangling |
|-----------|---------------|----------|---------------|
| C (cdecl) | Right to left | `Caller` | _symbol       |
| Pascal    | Left to right | Callee   | symbol        |
| Stdcall   | Right to left | Callee   | _symbol@4     |
| Fastcall  | Right to left | Callee   | @symbol@8     |

Parametrs `right to left` means that pushing on stack last param .. n-param .. first param

### Caller cleanup
```asm 
add esp, <4*N>
```

### Callee cleanup
```asm
ret <4*N>
```
*where 4 is number of bytes that stored in stack*
*and N is number of arguments*

# Other useful info
* Tasks are stored in `docs` folder in repo.
* If you want to contribute, please read `CONTRIBUTING.md` file.

### String instruction
```asm
x = typ (b, w, d, q)

MOVS[X] - copies ESI -> EDI
CMPS[X] - compare [ESI] - [EDI]
SCAS[X] - compare A - [EDI]
STOS[X] - copies A -> EDI
LODS[X] - read value from ESI -> A

!!! after execution instruction ESI/EDI increments !!!

REP[E,NE,Z,NZ] instructions - while (E)CX <> 0 do {MOVS/LODS/STOS/INS/OUTS};
```
