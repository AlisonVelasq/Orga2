; Programa Hola Orga que usa syscall de x86_64
; 
;* Obtenido de man 2 syscall
;* En x86-64
;*
;* System  Ret  Ret  Error
;* call #  val  val2     -
;*
;* rax     rax  rdx
;*
;* Los parámetros de syscall deben pasarse
;* arg1  arg2  arg3  arg4  arg5  arg6
;* rdi   rsi   rdx   r10   r8    r9

; system call numbers
; https://github.com/torvalds/linux/blob/master/arch/x86/entry/syscalls/syscall_64.tbl
; https://unix.stackexchange.com/questions/421750/where-do-you-find-the-syscall-table-for-linux

%define SYS_WRITE 1
%define SYS_EXIT 60
%define STDOUT 1
section .data

msg db  'Hola Orga 2!', 10
len EQU $-msg

global _start

section .text
_start:
    mov     rax, SYS_WRITE  
                            ;ssize_t write(int fd, const void *buf, size_t count);

    mov     rdi, STDOUT      
    mov     rsi, msg
    mov     rdx, len

    syscall                 ; fast system call
                            ; RCX    --> dirección de retorno
                            ; RFLAGS --> R11
; en este punto RAX tiene los bytes escritos por sys_write()
    mov     rax, SYS_EXIT   ; exit
    mov     rdi, 0
    syscall
