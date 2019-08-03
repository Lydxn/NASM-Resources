<h2>Resources</h2>

Most of these resources were learnt from kupala's YouTube playlist:
<br>https://www.youtube.com/playlist?list=PLetF-YjXm-sCH6FrTz4AQhfH6INDQvQSn
<br>
<br>X86 Assembly Wiki:
<br>https://en.wikibooks.org/wiki/X86_Assembly/X86_Architecture

<h2>Registers:</h2>

![list of registers](https://i.stack.imgur.com/N0KnG.png)

<h3>General Purpose Registers:</h3>

| Symbol | Meaning | Use |
| --- | --- | --- |
| RAX | Accumulator | Arithemtic Operations |
| RBX | Base | Pointer to Data |
| RCX | Counter | Shift/Rotate Instructions or Loops |
| RDX | Data | Arithemtic or I/O Operations |
| RSI | Source Index | Pointer to Source in Stream Operations |
| RDI | Destination Index | Pointer to Destination in Stream Operations |
| RSP | Stack Pointer | Pointer to the Top of the Stack |
| RBP | Stack Base Pointer | Point to the Base of the Stack |

<h2>System Call:</h2>

A very useful Linux system call table: https://blog.rchapman.org/posts/Linux_System_Call_Table_for_x86_64/

| rax | System call | rdi | rsi | rdx |
| --- | ----------- | --- | --- | --- |
| 0 | sys_read | #filedescriptor | $buffer | #count |
| 1 | sys_write | #filedescriptor | $buffer | #count |
| 2 | sys_open | $filename | #flag | #mode |
| ... | ... | ... | ... | ... | ... |

<h2>Flags:</h2>

- Registers that hold data (1 bit each, true or refalse)
- Each flag is part of a larger register

| Symbol | Meaning |
| --- | --- |
| CF | Carry |
| PF | Parity |
| AF | Adjust |
| ZF | Zero |
| SF | Sign |
| TF | Trap |
| IF | Interrupt |
| DF | Direction |
| OF | Overflow |
| ... | ... |

<h2>Pointers:</h2>

- Like flags, are registers that hold data
- They hold the memory address of some data

| Name | Meaning | Description |
| --- | --- | --- |
| rip (eip, ip) | Instruction Pointer | Points to next address to be executed in control flow |
| rsp (esp, sp) | Stack Pointer | Points to the top address of the stack |
| rbp (ebp, bp) | Stack Base Pointer | Points to the bottom of the stack |

<h2>Instructions:</h2>

List of instructions: https://www.felixcloutier.com/x86/

<h3>Comparisons:</h3>

- Allow programs to take different paths based on certain conditions
- They are done on registers
- The format of <b>cmp</b> is typically `cmp register, value/register`
- After a comparison, certain flags are set

<h3>Example:</h3>

```
cmp rax, 23
cmp rax, rbx
 ```
 
<h2>Conditional Jumps:</h2>
 
- After a comparison, a conditional jump can be made
- They are based on the status of the flags

| Symbol (signed) | Symbol (unsigned) | Result of <b>cmp</b> a, b |
| --- | --- | --- |
| je | - | a = b |
| jne | - | a ≠ b |
| jg | ja | a > b |
| jge | jae | a ≥ b |
| jl | jb | a < b |
| jle | jbe | a ≤ b |
| jz | - | a = 0 |
| jnz | - | a ≠ 0 |
| jo | - | Overflow |
| jno | - | Not Overflow |
| js | - | Jump If Signed |
| jns | - | Jump If Not Signed |

<h3>Examples:</h3>

```
cmp rax, 23
je _doThis
```
```
cmp rax, rbx
jg _doThis
```

<h2>Math Operations:</h2>

- used to mathematically manipulate registers
- The format of a math operation is typically `oper register, value/register`
- The result of the operation is stored in the first register

| Name (unsigned) | Name (signed) | Description |
| --- | --- | --- |
| add a, b | - | a = a + b |
| sub a, b | - | a = a - b |
| mul reg | imul reg | rax = rax * reg |
| div reg | idiv reg | rax = rax / reg |
| neg reg | - | reg = -reg |
| inc reg | - | reg = reg + 1 |
| dec reg | - | reg = reg - 1 |
| adc a, b | - | a = a + b + CF |
| sbb a, b | - | a = a - b - CF |

<h2>Stack Operations:</h2>

| Operation | Effect |
| --- | --- |
| `push reg/value` | Pushes a value onto the stack |
| `pop reg` | Pops a value off the stack and stores it in 'reg' |
| `mov reg, [rsp]` | Stores the peek value in 'reg' |

<h2>Macros:</h2>

- An instruction that expands into a predefined set of instructions to perform a particular task

<h3>Defining Macros:</h3>

```
%macro <name> <argc>
    ...
    <macro body>
    ...
%endmacro
```

``` html
<name>
    Name of macro
<argc>
    Number of arguments
<macro body>
    Definition of macro
```

<h3>Example:</h3>

```
; a NASM macro to add two numbers and store it in rax
%macro sumTwoNumbers 2
    mov rax, %1        ; move argument 1 into rax
    add rax, %2        ; add rax and argument 2 and store it in rax
%endmacro
```

<h2>File Permissions:</h2>

- We need to get the permission value (octal) first
- r = read, w = write, x = execute, sst = special attributes

![permissions](https://www.oreilly.com/library/view/linux-pocket-guide/9780596806347/httpatomoreillycomsourceoreillyimages305342.png)

<h2>Write to File:</h2>

<h3>Example:</h3>

```
section .data
    filename db "myfile.txt", 0                ; null-terminated file string
    text     db "Here's some text."            ; text to write to file
    textLen  equ $ - text                      ; length of text to write
 
section .text
    global _start
    
_start:
    mov rax, 2                                 ; argument to call 'sys_open'
    mov rdi, filename                          ; argument for file name
    mov rsi, 64+1                              ; argument for create (64) and write (1) flag
    mov rdx, 0644o                             ; argument for file permission value, suffix 'o' for octal
    syscall
    
    mov rdi, rax                               ; argument for file descriptor (stored in rax)
    mov rax, 1                                 ; argument to call 'sys_write'
    mov rsi, text                              ; argument for text to write to file
    mov rdx, textLen                           ; argument for text length (textLen)
    syscall
    
    mov rax, 3                                 ; argument to call 'sys_close'
    syscall
    
    mov rax, 60                                ; argument to call 'sys_exit'
    mov rdi, 0                                 ; argument for error code (0)
    syscall
```

<h2>Size Operands:</h2>
 
| Size (bits) | Operands |
| --- | --- |
| 8 | `byte, DB, RESB` |
| 16 | `word, DW, RESW` |
| 32 | `dword, DD, RESD` |
| 64 | `qword, DQ, RESQ` |
| 80 | `tword, DT, REST` |
| 128 | `oword, DO, DDQ, RESO, RESDQ` |
| 256 | `yword, DY, RESY` |
| 512 | `zword, DZ, RESZ` |

<h2>Miscellanous:</h2>

- Use `%include 'file.h'` to include other NASM files
- When using `mul` or `div`, the result is stored int `rdx:rax`,  where rdx is the high bits, and rax is the low bits
