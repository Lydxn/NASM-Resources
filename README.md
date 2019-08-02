<b>Most of these resources were learnt from kupala's YouTube playlist:</b>
<br>https://www.youtube.com/playlist?list=PLetF-YjXm-sCH6FrTz4AQhfH6INDQvQSn

<h2>A list of registers:</h2>

![Registers](https://i.stack.imgur.com/N0KnG.png)

<h2>System Call:</h2>
A very useful Linux system call table: https://blog.rchapman.org/posts/Linux_System_Call_Table_for_x86_64/

| rax | System call | rdi | rsi | rdx |
| --- | ----------- | --- | --- | --- |
| 0 | sys_read | #filedescriptor | $buffer | #count |
| 1 | sys_write | #filedescriptor | $buffer | #count |
| 2 | sys_open | $filename | #flag | #mode |
| 60 | sys_exit | #error_code | - | - |

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

<h2>Pointers:</h2>

- Like flags, are registers that hold data
- They hold the memory address of some data

| Name | Meaning | Description |
| --- | --- | --- |
| rip (eip, ip) | Index Pointer | Points to next address to be executed in control flow |
| rsp (esp, sp) | Stack Pointer | Points to the top address of the stack |
| rbp (ebp, bp) | Stack Base Pointer | Points to the bottom of the stack |

<h2>Instructions:</h2>

List of instructions: https://www.felixcloutier.com/x86/

<h3>Comparisons:</h3>

- Allow programs to take different paths based on certain conditions
- They are done on registers
- The format of <b>cmp</b> is `cmp register, value`
- After a comparison, certain flags are set

```
cmp rax, 23
cmp rax, rbx
 ```
 
<h3>Conditional Jumps:</h3>
 
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

```
cmp rax, 23
je _doThis
```
```
cmp rax, rbx
jg _doThis
```
