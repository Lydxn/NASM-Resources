section .data                        ; section to define memory
    msg db  "Hello, World!", 10      ; define string to the name 'msg', 10 is '\n' character
    len equ $ - msg                  ; assign the length of the string to the name 'len'
        
section .text                        ; section to put code
    global _start                    ; a global label to be declared for the linker (ld)
        
_start:
    mov rax, 1                       ; syscall ID number (sys_write)
    mov rdi, 1                       ; file descriptor (stdout)
    mov rsi, msg                     ; address of string to write
    mov rdx, len                     ; length of string
    syscall                          ; call kernel
        
    mov rax, 60                      ; syscall ID number (sys_exit)
    mov rdi, 0                       ; error code 0
    syscall                          ; call kernel
