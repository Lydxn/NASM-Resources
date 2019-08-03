; for DMOJ

section .data
        in3format db "%d %d %d", 0              ; scanf format to scan 3 integers
        outformat db "%d", 10, 0                ; printf format to print an integer and a newline

section .bss
        ; declare A, B, C with 8 bytes
        A resb 8
        B resb 8
        C resb 8

section .text
        global main
        extern scanf                            ; use scanf from libc 
        extern printf                           ; use printf from libc
    
main:
        sub rsp, 256                            ; align stack
    
        ; perform scanf
        mov rdi, in3format
        mov rsi, A
        mov rdx, B
        mov rcx, C
        xor rax, rax                            ; zero-out rax
        call scanf
    
        ; calculate mean and store in rax
        xor rdx, rdx                            ; zero-out rdx
        mov rax, [A]
        add rax, [B]
        add rax, [C]
        mov rcx, 3
        div rcx
    
        ; perform printf
        mov rdi, outformat
        mov rsi, rax
        xor rax, rax                            ; zero-out rax
        call printf
    
        xor rax, rax                            ; zero-out rax
        add rsp, 256                            ; restore stack
        ret                                     ; return with no error
