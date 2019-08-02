section .bss
        digit    resb 100               ; stores string to print integer
        digitPos resb 8                  ; stores current position of string
        
section .text
        global _start
        
_start:
        mov rax, 1234                   ; store 1234 in rax, the integer to print
        call _printInteger              ; call subroutine '_printInteger'
        
        ; perform sys_exit
        mov rax, 60
        mov rdi, 0
        syscall

; prints integer in rax
_printInteger:
        mov rcx, digit                  ; start at beginning of integer
        mov rbx, 10                     ; move newline into rbx
        mov [rcx], rbx                  ; move newline into rcx
        inc rcx                         ; (increment
        mov [digitPos], rcx             ; 'digitPos')

; loop to store value of integer in ASCII
_loopStore:
        xor rdx, rdx                    ; zero-out rdx register
        mov rbx, 10                     ; (divide rbx
        div rbx                         ; by 10)
        push rax                        ; store the value of rax
        add rdx, 48                     ; rdx is the remainder of rax / rbx, and add 48 to give its ASCII value
        
        mov rcx, [digitPos]             ; increment 'digitPos' position
        mov [rcx], dl                     ; load the character of rdx
        inc rcx                         ; (increment
        mov [digitPos], rcx             ; 'digitPos')
        
        pop rax                         ; get rax value
        cmp rax, 0                      ; (continue loop until
        jne _loopStore                  ; rax becomes 0)

; loop to print string backwards
_loopPrint:
        mov rcx, [digitPos]             ; move 'digitPos' to rcx
        
        ; perform sys_write
        mov rax, 1
        mov rdi, 1
        mov rsi, rcx
        mov rdx, 1
        syscall
        
        ; decrement 'digitPos'
        mov rcx, [digitPos]
        dec rcx
        mov [digitPos], rcx
        
        ; continue loop until beginning of string
        cmp rcx, digit
        jge _loopPrint
        ret
