.data
msg: .ascii "AAAAAAAA\0"

.text
.global _start
.intel_syntax noprefix

## gcc -g -nostdlib loopy.S -o loop
## hase record ./loopy a b c d e

_start:
    movq r8, [rsp]
again:
    cmp r8, 1
    jz exit
    ## if (argc) goto exit;
    
    movq rax, 1
    movq rdi, 1
    mov rsi, offset msg
    movq rdx, 2
    syscall
    ## write(1, &msg, 12); // msg -> "A\n"
    
    dec r8
    cmp r8, 1
    	jnz again
    ## if (!argc) goto again;

exit:
    movq rax, 39
    syscall
    ## getpid();
    movq rdi, rax ## pid -> for kill
    
    movq rax, 62
    movq rsi, 6
    syscall
    ## kill(getpid(), SIGABRT);
    
    # <- should be never executed
    movq rax, 4141
