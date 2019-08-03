; for DMOJ

section .data
        in3format db "%ld %ld %ld", 0           ; scanf format to scan 3 integers
        outformat db "%ld", 10, 0               ; printf format to print an integer and a newline

section .text
        global main
        extern scanf                            ; use scanf from libc 
        extern printf                           ; use printf from libc
    
main:
        sub rsp, 256                            ; align stack
    
        ; perform scanf
        mov rdi, in3format
        lea rsi, [rsp]
        lea rdx, [rsp + 8]
        lea rcx, [rsp + 16]
        xor rax, rax                            ; zero-out rax
        call scanf
    
        ; calculate mean and store in rax
        xor rdx, rdx                            ; zero-out rdx
        mov rax, [rsp]
        add rax, [rsp + 8]
        add rax, [rsp + 16]
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
