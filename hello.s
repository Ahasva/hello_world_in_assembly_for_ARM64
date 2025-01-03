// "hello world" in assemby on ARM64 Apple Silicon

// A list of Apple OS ARM system calls can be found here: https://theapplewiki.com/wiki/Kernel_Syscalls

// Alternatively you could use _start, but _main resembles the `main` func in C or C##
.global _main

// The 2 in the following libe is necessary, if code is run on Apple Silicon,
// if used on Raspberry Pi you have to use 4 instead of 2
.align 2

// main function
_main:
    b _printf
    //b _reboot
    b _terminate

_printf:
    mov X0, #1 // stdout
    adr X1, helloworld // address of hello world string
    mov X2, #13 // length of hello world string
    mov X16, #4 // write to stdout
    svc 0 // syscall

_reboot:
    mov X0, #1 // instant reboot
    mov X16, #55 // reboot
    svc 0 // syscall

_terminate:
    mov X0, #0 // return 0 
    // comment on previous line: register `X0` to `X7` are for parameters of functions
    // (here it says, that the number 0 is passed / moved (= mov) into the param X0)
    
    mov X16, #1 // terminate
    // comment on previous line: X16 is the invocation of a following Linux service command (supervisor call);
    // `#1` stands for a termination call, which is called by the supervisor call

    svc 0 // syscall
    // the actual supervisor call

helloworld: .ascii "Hello World!\n"