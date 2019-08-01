<h2>A list of registers:</h2>

![Registers](https://i.stack.imgur.com/N0KnG.png)

<h2>System Call:</h2>
A very useful Linux system call table: https://blog.rchapman.org/posts/Linux_System_Call_Table_for_x86_64/

<h3>Examples:</h3>

| rax | System call | rdi | rsi | rdx |
| --- | ----------- | --- | --- | --- |
| 0 | sys_read | #filedescriptor | $buffer | #count |
| 1 | sys_write | #filedescriptor | $buffer | #count |
| 2 | sys_open | $filename | #flags | #mode |
| 60 | sys_exit | #error_code | N/A | N/A |
