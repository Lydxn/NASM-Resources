section .data
        fizz    db "Fizz"
        buzz    db "Buzz"
        newline db 10
        digit   db 0
        
section .text
        global _start
        
; macro to print string using 'print string, stringLen'
%macro print 2
        push rcx
        mov rax, 1
        mov rdi, 1
        mov rsi, %1
        mov rdx, %2
        syscall
        pop rcx
%endmacro

; macro to take the modulus of rcx using 'mod number'
%macro mod 1
        xor rdx, rdx                    ; zero-out rdx (remainder)
        mov rax, rcx                    ; move rcx into rax
        mov rbx, %1                     ; move %1 into rbx
        div rbx                         ; get remainder of rax / rbx in rdx register
        cmp rdx, 0                      ; compare rcx with 0
%endmacro
        
_start:
        mov rcx, 1                      ; start counter at 1
        call _fizzBuzz                  ; call subroutine '_fizzBuzz'
        
        ; perform sys_exit
        mov rax, 60
        mov rdi, 0
        syscall
        
_fizzBuzz:        
        mod 15                          ; calculate rcx % 15
        je _printFizzBuzz               ; jump to _printFizzBuzz if rax := 0
        mod 3                           ; calculate rcx % 3
        je _printFizz                   ; jump to _printFizz if rax := 0
        mod 5                           ; calculate rcx % 5
        je _printBuzz                   ; jump to _printBuzz if rax := 0
        
        mov rax, rcx                    ; mov rcx into rax
        push rcx                        ; preserve rcx
        call _printInteger              ; print rax
        pop rcx                         ; retrieve rcx

_next:
        print newline, 1
        inc rcx
        cmp rcx, 100                    ; (continue loop
        jle _fizzBuzz                   ; until rcx <= 100)
        ret
        
_printFizzBuzz:
        print fizz, 4                   ; print "Fizz"
        print buzz, 4                   ; print "Buzz"
        jmp _next
        
_printFizz:
        print fizz, 4                   ; print "Fizz"
        jmp _next
        
_printBuzz:
        print buzz, 4                   ; print "Buzz"
        jmp _next

; prints integer in rax
_printInteger:
        mov rcx, digit                  ; start at beginning of integer

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
        print rcx, 1
        
        pop rcx                         ; get back position
        dec rcx                         ; decrement position
        cmp rcx, digit                  ; (continue loop until 
        jge _loopPrint                  ; end of string)
        ret
