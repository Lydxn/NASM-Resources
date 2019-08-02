section .data
        ask      db "What is your name? "          ; string to ask for user's name
        askLen   equ $ - ask                       ; get length of the string 'ask'
        hello    db "Hello, "                      ; string to say hello to user
        helloLen equ $ - hello                     ; get length of the string 'hello'

section .bss
        name resb 32                               ; reserve 32 bytes of space for user input string

section .text
        global _start
        
_start:
        ; call subroutines
        call _writeAsk
        call _readName
        call _writeHello
        call _writeName
        
        ; perform sys_exit
        mov rax, 60
        mov rdi, 0
        syscall
        
_writeAsk:
        ; perform sys_write
        mov rax, 1
        mov rdi, 1
        mov rsi, ask
        mov rdx, askLen
        syscall
        ret
        
_readName:
        ; perform sys_read
        mov rax, 0
        mov rdi, 0
        mov rsi, name
        mov rdx, 32
        syscall
        ret
        
_writeHello:
        ; perform sys_write
        mov rax, 1
        mov rdi, 1
        mov rsi, hello
        mov rdx, helloLen
        syscall
        ret
        
_writeName:
        ; perform sys_write
        mov rax, 1
        mov rdi, 1
        mov rsi, name
        mov rdx, 32
        syscall
        ret
