section .data
        digit db 0, 10                  ; define the digit as 0 and newline

section .text
        global _start
        
_start:
        mov rax, 7                      ; set the digit to print as '7'
        add rax, 48                     ; 48 is the value of the character '0' in ASCII, '1' is 49...
        mov [digit], al                 ; move lower byte of rax register to address 'digit'
        
        ; perform sys_write
        mov rax, 1
        mov rdi, 1
        mov rsi, digit
        mov rdx, 2
        syscall
        
        mov rax, 60
        mov rdi, 0
        syscall
