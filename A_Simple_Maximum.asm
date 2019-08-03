; using NASM 32-bit

section .data
    informat   db "%d", 0                 ; scanf format to scan an integer
    out2format db "%d %d", 10, 0          ; printf format to print two space-separated integers and a newline
    min        dd 128                     ; initialize min with max possible value
    max        dd -127                    ; initialize max with min possible value
    
section .bss
    N         resb 4                      ; declare N as number of elements in list
    num       resb 4                      ; declare num as element of list

section .text
    global main
    extern scanf                          ; use scanf from libc 
    extern printf                         ; use printf from libc
    
; macro to scan for an integer using 'scanInt format, variable'
%macro scanInt 2
    push %2
    push %1
    xor eax, eax
    call scanf
    add esp, 8
%endmacro

; macro to print two integers using 'print2Int format, variable1, variable2'
%macro print2Int 3
    push %3
    push %2
    push %1
    xor eax, eax
    call printf
    add esp, 12
%endmacro
    
main:
    scanInt informat, N                   ; scan integer 'N'
    mov ecx, [N]                          ; move 'N' into rcx
    call _minMax                          ; find minimum (rax) and maximum (rbx)
    
    print2Int out2format, eax, ebx        ; print min and max
    
    xor eax, eax                          ; zero-out rax
    ret                                   ; return with no error
    
_minMax:
    push ecx                              ; reserve rcx (counter)
    scanInt informat, num                 ; scan integer 'num'
    pop ecx                               ; retrieve rcx (counter)
    
    mov eax, [num]                        ; move num into eax register
    
    cmp eax, [min]
    jl _newMin                            ; if eax < min, calculate new min
_nextMin:

    cmp eax, [max]
    jg _newMax                            ; if eax > max, calculate new max
_nextMax:

    loop _minMax                          ; loop until ecx (counter) is equal to 0
    mov eax, [min]                        ; move min into eax register
    mov ebx, [max]                        ; move max into ebx register
    ret
    
_newMin:
    mov [min], eax
    jmp _nextMin

_newMax:
    mov [max], eax
    jmp _nextMax
