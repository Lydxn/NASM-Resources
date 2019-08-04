section .data
    digitSpace db 0

section .text
	global _start

_start:
    	mov rcx, 50                    ; set rcx to '50' (number of fibonacci iterations)
    	mov r8, 0                      ; set r8 to '0'
    	mov r9, 1                      ; set r9 to '1'
    	call _fib                      ; call '_fib' subroutine to calculate fibonacci
    
    	; perform sys_exit
	mov rax, 60
    	mov rdi, 0
    	syscall
    
_fib:
    	push rcx                       ; preserve rcx
    	call _printInteger             ; call subroutine to print a 64-bit integer
    	pop rcx                        ; retrieve rcx
    
    	mov rax, r8                    ; (set rax equal
    	add rax, r9                    ; to r8 + r9)
    	mov r8, r9                     ; move r9 into r8
    	mov r9, rax                    ; move rax into r9
    
    	loop _fib                      ; loop 'rcx' times
    
; prints integer in r8
_printInteger:
        mov rcx, digitSpace             ; start at beginning of integer
        mov rbx, 10                     ; move newline into rbx
        mov [rcx], rbx                  ; move newline into rcx
        inc rcx                         ; increment rcx (position)

; loop to store value of integer
_loopStore:
        xor rdx, rdx                    ; zero-out rdx register
        mov rbx, 10                     ; (divide rbx
        div rbx                         ; by 10)

        add rdx, 48                     ; rdx is the remainder of rax / rbx, and add 48 to give its ASCII value

        mov [rcx], dl                   ; load the character of rdx
        inc rcx                         ; increment position

        cmp rax, 0                      ; (continue loop until
        jne _loopStore                  ; rax becomes 0)

; loop to print string backwards
_loopPrint:
        push rcx                        ; push rcx into stack
        
        ; perform sys_write
        mov rax, 1
        mov rdi, 1
        mov rsi, rcx
        mov rdx, 1
        syscall
        
        pop rcx                        ; get back position
        dec rcx                        ; decrement position
        cmp rcx, digitSpace            ; (continue loop until 
        jge _loopPrint                 ; end of string)
        ret
