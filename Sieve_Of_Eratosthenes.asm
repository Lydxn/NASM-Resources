section .data
        digit db 0
        isPrime times 100 dq 1                  ; set bool array isPrime of size 100 to true
        
section .text
        global _start
        
_start:
        mov rsi, isPrime                        ; rsi is pointer to isPrime
        mov r8, 2                               ; move 2 into r8 (outer loop counter)
        call _printSieve                        ; call subroutine '_printSieve'
        
        ; perform sys_exit
        mov rax, 60
        mov rdi, 0
        syscall
        
_printSieve:
        cmp qword [rsi + r8 * 8], 0             ; compare isPrime[r8] to 'false' value
        je _skip1                               ; jump to '_skip1' if 'isPrime[r8] := false'
        
        mov rax, r8                             ; move r8 into rax
        mul rax                                 ; square rax
        mov r9, rax                             ; move rax into r9 (inner loop counter)
        
_loopInner:
        mov qword [rsi + r9 * 8], 0             ; set isPrime[r9] to 'false' value
        add r9, r8                              ; increment r9 by r8
        cmp r9, 100                             ; (continue loop until
        jle _loopInner                          ; 'r9 <= 100')
        
_skip1:
        inc r8
        cmp r8, 10                              ; (continue loop until
        jle _printSieve                         ; 'r8 <= sqrt(100)')
        mov rax, 2                              ; move 2 to rax

; loop to print sieve
_loopPrintSieve:
        cmp qword [rsi + rax * 8], 0            ; compare isPrime[rax] with 'false' value
        je _skip2                               ; jump to '_skip2' if 'isPrime[rax] := false'
        
        push rax                                ; preserve rax
        call _printInteger                      ; call subroutine 'printInteger'
        pop rax                                 ; retrieve rax

_skip2:
        inc rax
        cmp rax, 100                            ; (continue loop until
        jle _loopPrintSieve                     ; rax <= 100)
        ret

; prints integer in rax
_printInteger:
        mov rcx, digit                          ; start at beginning of integer
        mov rbx, 10                             ; move newline into rbx
        mov [rcx], rbx                          ; move newline into rcx
        inc rcx                                 ; increment rcx (position)

; loop to store value of integer
_loopStore:
        xor rdx, rdx                            ; zero-out rdx register
        mov rbx, 10                             ; (divide rbx
        div rbx                                 ; by 10)

        add rdx, 48                             ; rdx is the remainder of rax / rbx, and add 48 to give its ASCII value

        mov [rcx], dl                           ; load the character of rdx
        inc rcx                                 ; increment position

        cmp rax, 0                              ; (continue loop until
        jne _loopStore                          ; rax becomes 0)

; loop to print string backwards
_loopPrint:
        push rcx                                ; push rcx into stack
        
        ; perform sys_write
        mov rax, 1
        mov rdi, 1
        mov rsi, rcx
        mov rdx, 1
        syscall
        
        pop rcx                                ; get back position
        dec rcx                                ; decrement position
        cmp rcx, digit                         ; (continue loop until 
        jge _loopPrint                         ; end of string)
        ret
