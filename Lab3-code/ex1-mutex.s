	.file	"ex1-mutex.c"
	.text
.Ltext0:
	.cfi_sections	.debug_frame
	.comm	lock, 8, 3
	.section .rdata,"dr"
	.align 8
.LC0:
	.ascii "About to increase variable %d times\12\0"
.LC1:
	.ascii "Done increasing variable.\12\0"
	.text
	.globl	increase_fn
	.def	increase_fn;	.scl	2;	.type	32;	.endef
	.seh_proc	increase_fn
increase_fn:
.LFB17:
	.file 1 "ex1-mutex.c"
	.loc 1 42 1
	.cfi_startproc
	pushq	%rbp
	.seh_pushreg	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	.seh_stackalloc	48
	.seh_endprologue
	movq	%rcx, 16(%rbp)
	.loc 1 44 23
	movq	16(%rbp), %rax
	movq	%rax, -16(%rbp)
	.loc 1 46 9
	movl	$2, %ecx
	movq	__imp___acrt_iob_func(%rip), %rax
	call	*%rax
.LVL0:
	movl	$10000000, %r8d
	leaq	.LC0(%rip), %rdx
	movq	%rax, %rcx
	call	fprintf
	.loc 1 47 16
	movl	$0, -4(%rbp)
	.loc 1 47 9
	jmp	.L2
.L3:
	.loc 1 55 25
	leaq	lock(%rip), %rax
	movq	%rax, %rcx
	call	pthread_mutex_lock
	.loc 1 57 28
	movq	-16(%rbp), %rax
	movl	(%rax), %eax
	.loc 1 57 25
	leal	1(%rax), %edx
	movq	-16(%rbp), %rax
	movl	%edx, (%rax)
	.loc 1 59 25
	leaq	lock(%rip), %rax
	movq	%rax, %rcx
	call	pthread_mutex_unlock
	.loc 1 47 29
	addl	$1, -4(%rbp)
.L2:
	.loc 1 47 9 discriminator 1
	cmpl	$9999999, -4(%rbp)
	jle	.L3
	.loc 1 62 9
	movl	$2, %ecx
	movq	__imp___acrt_iob_func(%rip), %rax
	call	*%rax
.LVL1:
	movq	%rax, %r9
	movl	$26, %r8d
	movl	$1, %edx
	leaq	.LC1(%rip), %rcx
	call	fwrite
	.loc 1 64 16
	movl	$0, %eax
	.loc 1 65 1
	addq	$48, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE17:
	.seh_endproc
	.section .rdata,"dr"
	.align 8
.LC2:
	.ascii "About to decrease variable %d times\12\0"
.LC3:
	.ascii "Done decreasing variable.\12\0"
	.text
	.globl	decrease_fn
	.def	decrease_fn;	.scl	2;	.type	32;	.endef
	.seh_proc	decrease_fn
decrease_fn:
.LFB18:
	.loc 1 68 1
	.cfi_startproc
	pushq	%rbp
	.seh_pushreg	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	.seh_stackalloc	48
	.seh_endprologue
	movq	%rcx, 16(%rbp)
	.loc 1 70 23
	movq	16(%rbp), %rax
	movq	%rax, -16(%rbp)
	.loc 1 72 9
	movl	$2, %ecx
	movq	__imp___acrt_iob_func(%rip), %rax
	call	*%rax
.LVL2:
	movl	$10000000, %r8d
	leaq	.LC2(%rip), %rdx
	movq	%rax, %rcx
	call	fprintf
	.loc 1 73 16
	movl	$0, -4(%rbp)
	.loc 1 73 9
	jmp	.L6
.L7:
	.loc 1 81 25
	leaq	lock(%rip), %rax
	movq	%rax, %rcx
	call	pthread_mutex_lock
	.loc 1 83 28
	movq	-16(%rbp), %rax
	movl	(%rax), %eax
	.loc 1 83 25
	leal	-1(%rax), %edx
	movq	-16(%rbp), %rax
	movl	%edx, (%rax)
	.loc 1 85 25
	leaq	lock(%rip), %rax
	movq	%rax, %rcx
	call	pthread_mutex_unlock
	.loc 1 73 29
	addl	$1, -4(%rbp)
.L6:
	.loc 1 73 9 discriminator 1
	cmpl	$9999999, -4(%rbp)
	jle	.L7
	.loc 1 88 9
	movl	$2, %ecx
	movq	__imp___acrt_iob_func(%rip), %rax
	call	*%rax
.LVL3:
	movq	%rax, %r9
	movl	$26, %r8d
	movl	$1, %edx
	leaq	.LC3(%rip), %rcx
	call	fwrite
	.loc 1 90 16
	movl	$0, %eax
	.loc 1 91 1
	addq	$48, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE18:
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
.LC4:
	.ascii "\12 mutex init has failed\0"
.LC5:
	.ascii "pthread_create\0"
.LC6:
	.ascii "pthread_join\0"
.LC7:
	.ascii "\0"
.LC8:
	.ascii "NOT \0"
.LC9:
	.ascii "%sOK, val = %d.\12\0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
.LFB19:
	.loc 1 95 1
	.cfi_startproc
	pushq	%rbp
	.seh_pushreg	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	.cfi_def_cfa_register 6
	subq	$64, %rsp
	.seh_stackalloc	64
	.seh_endprologue
	movl	%ecx, 16(%rbp)
	movq	%rdx, 24(%rbp)
	.loc 1 95 1
	call	__main
.LVL4:
	.loc 1 102 13
	movl	$0, -12(%rbp)
	.loc 1 103 13
	movl	$0, %edx
	leaq	lock(%rip), %rax
	movq	%rax, %rcx
	call	pthread_mutex_init
	.loc 1 103 12
	testl	%eax, %eax
	je	.L10
	.loc 1 104 11
	leaq	.LC4(%rip), %rcx
	call	puts
	.loc 1 105 18
	movl	$1, %eax
	jmp	.L18
.L10:
	.loc 1 110 15
	leaq	-12(%rbp), %rdx
	leaq	-24(%rbp), %rax
	movq	%rdx, %r9
	leaq	increase_fn(%rip), %r8
	movl	$0, %edx
	movq	%rax, %rcx
	call	pthread_create
	movl	%eax, -4(%rbp)
	.loc 1 111 12
	cmpl	$0, -4(%rbp)
	je	.L12
	.loc 1 112 17
	movq	__imp__errno(%rip), %rax
	call	*%rax
.LVL5:
	movq	%rax, %rdx
	movl	-4(%rbp), %eax
	movl	%eax, (%rdx)
	leaq	.LC5(%rip), %rcx
	call	perror
	.loc 1 113 17
	movl	$1, %ecx
	call	exit
.L12:
	.loc 1 115 15
	leaq	-12(%rbp), %rdx
	leaq	-32(%rbp), %rax
	movq	%rdx, %r9
	leaq	decrease_fn(%rip), %r8
	movl	$0, %edx
	movq	%rax, %rcx
	call	pthread_create
	movl	%eax, -4(%rbp)
	.loc 1 116 12
	cmpl	$0, -4(%rbp)
	je	.L13
	.loc 1 117 17
	movq	__imp__errno(%rip), %rax
	call	*%rax
.LVL6:
	movq	%rax, %rdx
	movl	-4(%rbp), %eax
	movl	%eax, (%rdx)
	leaq	.LC5(%rip), %rcx
	call	perror
	.loc 1 118 17
	movl	$1, %ecx
	call	exit
.L13:
	.loc 1 124 15
	movq	-24(%rbp), %rax
	movl	$0, %edx
	movq	%rax, %rcx
	call	pthread_join
	movl	%eax, -4(%rbp)
	.loc 1 125 12
	cmpl	$0, -4(%rbp)
	je	.L14
	.loc 1 126 17
	movq	__imp__errno(%rip), %rax
	call	*%rax
.LVL7:
	movq	%rax, %rdx
	movl	-4(%rbp), %eax
	movl	%eax, (%rdx)
	leaq	.LC6(%rip), %rcx
	call	perror
.L14:
	.loc 1 127 15
	movq	-32(%rbp), %rax
	movl	$0, %edx
	movq	%rax, %rcx
	call	pthread_join
	movl	%eax, -4(%rbp)
	.loc 1 128 12
	cmpl	$0, -4(%rbp)
	je	.L15
	.loc 1 129 17
	movq	__imp__errno(%rip), %rax
	call	*%rax
.LVL8:
	movq	%rax, %rdx
	movl	-4(%rbp), %eax
	movl	%eax, (%rdx)
	leaq	.LC6(%rip), %rcx
	call	perror
.L15:
	.loc 1 134 19
	movl	-12(%rbp), %eax
	testl	%eax, %eax
	sete	%al
	.loc 1 134 12
	movzbl	%al, %eax
	movl	%eax, -8(%rbp)
	.loc 1 136 9
	movl	-12(%rbp), %edx
	cmpl	$0, -8(%rbp)
	je	.L16
	.loc 1 136 9 is_stmt 0 discriminator 1
	leaq	.LC7(%rip), %rax
	jmp	.L17
.L16:
	.loc 1 136 9 discriminator 2
	leaq	.LC8(%rip), %rax
.L17:
	.loc 1 136 9 discriminator 4
	movl	%edx, %r8d
	movq	%rax, %rdx
	leaq	.LC9(%rip), %rcx
	call	printf
	.loc 1 138 16 is_stmt 1 discriminator 4
	movl	-8(%rbp), %eax
.L18:
	.loc 1 139 1 discriminator 1
	addq	$64, %rsp
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE19:
	.seh_endproc
.Letext0:
	.file 2 "C:/CodeBlocks/MinGW/x86_64-w64-mingw32/include/crtdefs.h"
	.file 3 "C:/CodeBlocks/MinGW/x86_64-w64-mingw32/include/stdlib.h"
	.file 4 "C:/CodeBlocks/MinGW/x86_64-w64-mingw32/include/malloc.h"
	.file 5 "C:/CodeBlocks/MinGW/x86_64-w64-mingw32/include/process.h"
	.file 6 "C:/CodeBlocks/MinGW/x86_64-w64-mingw32/include/getopt.h"
	.file 7 "C:/CodeBlocks/MinGW/x86_64-w64-mingw32/include/pthread.h"
	.file 8 "C:/CodeBlocks/MinGW/x86_64-w64-mingw32/include/errno.h"
	.file 9 "C:/CodeBlocks/MinGW/x86_64-w64-mingw32/include/stdio.h"
	.section	.debug_info,"dr"
.Ldebug_info0:
	.long	0x5e5
	.word	0x4
	.secrel32	.Ldebug_abbrev0
	.byte	0x8
	.uleb128 0x1
	.ascii "GNU C17 8.1.0 -mtune=core2 -march=nocona -g\0"
	.byte	0xc
	.ascii "ex1-mutex.c\0"
	.ascii "C:\\DOCUMENTS\\ECE_COURSES\\\321\317\307 \325\\6-\313\345\351\364\357\365\361\343\351\352\334 \323\365\363\364\336\354\341\364\341\\\305\361\343\341\363\364\347\361\351\341\352\335\362_\341\363\352\336\363\345\351\362\\3\347_\345\361\343\341\363\364\347\361\351\341\352\336\\Lab3-code\0"
	.quad	.Ltext0
	.quad	.Letext0-.Ltext0
	.secrel32	.Ldebug_line0
	.uleb128 0x2
	.byte	0x1
	.byte	0x6
	.ascii "char\0"
	.uleb128 0x2
	.byte	0x8
	.byte	0x7
	.ascii "long long unsigned int\0"
	.uleb128 0x2
	.byte	0x8
	.byte	0x5
	.ascii "long long int\0"
	.uleb128 0x3
	.ascii "uintptr_t\0"
	.byte	0x2
	.byte	0x4b
	.byte	0x2c
	.long	0xc9
	.uleb128 0x3
	.ascii "wchar_t\0"
	.byte	0x2
	.byte	0x62
	.byte	0x18
	.long	0x116
	.uleb128 0x2
	.byte	0x2
	.byte	0x7
	.ascii "short unsigned int\0"
	.uleb128 0x2
	.byte	0x4
	.byte	0x5
	.ascii "int\0"
	.uleb128 0x4
	.long	0x12c
	.uleb128 0x2
	.byte	0x4
	.byte	0x5
	.ascii "long int\0"
	.uleb128 0x5
	.byte	0x8
	.long	0xc1
	.uleb128 0x5
	.byte	0x8
	.long	0x106
	.uleb128 0x5
	.byte	0x8
	.long	0x12c
	.uleb128 0x2
	.byte	0x4
	.byte	0x7
	.ascii "unsigned int\0"
	.uleb128 0x2
	.byte	0x4
	.byte	0x7
	.ascii "long unsigned int\0"
	.uleb128 0x2
	.byte	0x1
	.byte	0x8
	.ascii "unsigned char\0"
	.uleb128 0x2
	.byte	0x8
	.byte	0x4
	.ascii "double\0"
	.uleb128 0x2
	.byte	0x4
	.byte	0x4
	.ascii "float\0"
	.uleb128 0x2
	.byte	0x10
	.byte	0x4
	.ascii "long double\0"
	.uleb128 0x6
	.ascii "__imp___mb_cur_max\0"
	.byte	0x3
	.byte	0x73
	.byte	0x10
	.long	0x150
	.uleb128 0x7
	.long	0x144
	.long	0x1d9
	.uleb128 0x8
	.long	0xc9
	.byte	0
	.byte	0
	.uleb128 0x6
	.ascii "_sys_errlist\0"
	.byte	0x3
	.byte	0xac
	.byte	0x26
	.long	0x1c9
	.uleb128 0x6
	.ascii "_sys_nerr\0"
	.byte	0x3
	.byte	0xad
	.byte	0x24
	.long	0x12c
	.uleb128 0x9
	.ascii "__imp___argc\0"
	.byte	0x3
	.word	0x119
	.byte	0x10
	.long	0x150
	.uleb128 0x9
	.ascii "__imp___argv\0"
	.byte	0x3
	.word	0x11d
	.byte	0x13
	.long	0x22c
	.uleb128 0x5
	.byte	0x8
	.long	0x232
	.uleb128 0x5
	.byte	0x8
	.long	0x144
	.uleb128 0x9
	.ascii "__imp___wargv\0"
	.byte	0x3
	.word	0x121
	.byte	0x16
	.long	0x24f
	.uleb128 0x5
	.byte	0x8
	.long	0x255
	.uleb128 0x5
	.byte	0x8
	.long	0x14a
	.uleb128 0x9
	.ascii "__imp__environ\0"
	.byte	0x3
	.word	0x127
	.byte	0x13
	.long	0x22c
	.uleb128 0x9
	.ascii "__imp__wenviron\0"
	.byte	0x3
	.word	0x12c
	.byte	0x16
	.long	0x24f
	.uleb128 0x9
	.ascii "__imp__pgmptr\0"
	.byte	0x3
	.word	0x132
	.byte	0x12
	.long	0x232
	.uleb128 0x9
	.ascii "__imp__wpgmptr\0"
	.byte	0x3
	.word	0x137
	.byte	0x15
	.long	0x255
	.uleb128 0x9
	.ascii "__imp__osplatform\0"
	.byte	0x3
	.word	0x13c
	.byte	0x19
	.long	0x2d6
	.uleb128 0x5
	.byte	0x8
	.long	0x156
	.uleb128 0x9
	.ascii "__imp__osver\0"
	.byte	0x3
	.word	0x141
	.byte	0x19
	.long	0x2d6
	.uleb128 0x9
	.ascii "__imp__winver\0"
	.byte	0x3
	.word	0x146
	.byte	0x19
	.long	0x2d6
	.uleb128 0x9
	.ascii "__imp__winmajor\0"
	.byte	0x3
	.word	0x14b
	.byte	0x19
	.long	0x2d6
	.uleb128 0x9
	.ascii "__imp__winminor\0"
	.byte	0x3
	.word	0x150
	.byte	0x19
	.long	0x2d6
	.uleb128 0x6
	.ascii "_amblksiz\0"
	.byte	0x4
	.byte	0x35
	.byte	0x17
	.long	0x156
	.uleb128 0x6
	.ascii "__security_cookie\0"
	.byte	0x5
	.byte	0x7d
	.byte	0x14
	.long	0xf4
	.uleb128 0x6
	.ascii "optind\0"
	.byte	0x6
	.byte	0x16
	.byte	0xc
	.long	0x12c
	.uleb128 0x6
	.ascii "optopt\0"
	.byte	0x6
	.byte	0x17
	.byte	0xc
	.long	0x12c
	.uleb128 0x6
	.ascii "opterr\0"
	.byte	0x6
	.byte	0x18
	.byte	0xc
	.long	0x12c
	.uleb128 0x6
	.ascii "optarg\0"
	.byte	0x6
	.byte	0x1b
	.byte	0xe
	.long	0x144
	.uleb128 0x2
	.byte	0x2
	.byte	0x5
	.ascii "short int\0"
	.uleb128 0xa
	.byte	0x8
	.uleb128 0x3
	.ascii "pthread_t\0"
	.byte	0x7
	.byte	0xc4
	.byte	0x13
	.long	0xf4
	.uleb128 0xb
	.long	0x3cf
	.uleb128 0xc
	.long	0x3b0
	.byte	0
	.uleb128 0x5
	.byte	0x8
	.long	0x3c4
	.uleb128 0xd
	.ascii "pthread_mutex_t\0"
	.byte	0x7
	.word	0x10d
	.byte	0xf
	.long	0x3b0
	.uleb128 0x9
	.ascii "_pthread_key_dest\0"
	.byte	0x7
	.word	0x123
	.byte	0x1f
	.long	0x409
	.uleb128 0x5
	.byte	0x8
	.long	0x3cf
	.uleb128 0xe
	.ascii "lock\0"
	.byte	0x1
	.byte	0x27
	.byte	0x11
	.long	0x3d5
	.uleb128 0x9
	.byte	0x3
	.quad	lock
	.uleb128 0xf
	.ascii "main\0"
	.byte	0x1
	.byte	0x5e
	.byte	0x5
	.long	0x12c
	.quad	.LFB19
	.quad	.LFE19-.LFB19
	.uleb128 0x1
	.byte	0x9c
	.long	0x4e6
	.uleb128 0x10
	.ascii "argc\0"
	.byte	0x1
	.byte	0x5e
	.byte	0xe
	.long	0x12c
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x10
	.ascii "argv\0"
	.byte	0x1
	.byte	0x5e
	.byte	0x1a
	.long	0x232
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x11
	.ascii "val\0"
	.byte	0x1
	.byte	0x60
	.byte	0xd
	.long	0x12c
	.uleb128 0x2
	.byte	0x91
	.sleb128 -28
	.uleb128 0x11
	.ascii "ret\0"
	.byte	0x1
	.byte	0x60
	.byte	0x12
	.long	0x12c
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x11
	.ascii "ok\0"
	.byte	0x1
	.byte	0x60
	.byte	0x17
	.long	0x12c
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x11
	.ascii "t1\0"
	.byte	0x1
	.byte	0x61
	.byte	0x13
	.long	0x3b2
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x11
	.ascii "t2\0"
	.byte	0x1
	.byte	0x61
	.byte	0x17
	.long	0x3b2
	.uleb128 0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x12
	.quad	.LVL5
	.long	0x5ca
	.uleb128 0x12
	.quad	.LVL6
	.long	0x5ca
	.uleb128 0x12
	.quad	.LVL7
	.long	0x5ca
	.uleb128 0x12
	.quad	.LVL8
	.long	0x5ca
	.byte	0
	.uleb128 0xf
	.ascii "decrease_fn\0"
	.byte	0x1
	.byte	0x43
	.byte	0x7
	.long	0x3b0
	.quad	.LFB18
	.quad	.LFE18-.LFB18
	.uleb128 0x1
	.byte	0x9c
	.long	0x555
	.uleb128 0x10
	.ascii "arg\0"
	.byte	0x1
	.byte	0x43
	.byte	0x19
	.long	0x3b0
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x11
	.ascii "i\0"
	.byte	0x1
	.byte	0x45
	.byte	0xd
	.long	0x12c
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x11
	.ascii "ip\0"
	.byte	0x1
	.byte	0x46
	.byte	0x17
	.long	0x555
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x12
	.quad	.LVL2
	.long	0x5dc
	.uleb128 0x12
	.quad	.LVL3
	.long	0x5dc
	.byte	0
	.uleb128 0x5
	.byte	0x8
	.long	0x133
	.uleb128 0xf
	.ascii "increase_fn\0"
	.byte	0x1
	.byte	0x29
	.byte	0x7
	.long	0x3b0
	.quad	.LFB17
	.quad	.LFE17-.LFB17
	.uleb128 0x1
	.byte	0x9c
	.long	0x5ca
	.uleb128 0x10
	.ascii "arg\0"
	.byte	0x1
	.byte	0x29
	.byte	0x19
	.long	0x3b0
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x11
	.ascii "i\0"
	.byte	0x1
	.byte	0x2b
	.byte	0xd
	.long	0x12c
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x11
	.ascii "ip\0"
	.byte	0x1
	.byte	0x2c
	.byte	0x17
	.long	0x555
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x12
	.quad	.LVL0
	.long	0x5dc
	.uleb128 0x12
	.quad	.LVL1
	.long	0x5dc
	.byte	0
	.uleb128 0x13
	.ascii "_errno\0"
	.ascii "_errno\0"
	.byte	0x8
	.byte	0x11
	.byte	0x1d
	.uleb128 0x14
	.secrel32	.LASF0
	.secrel32	.LASF0
	.byte	0x9
	.byte	0x52
	.byte	0x17
	.byte	0
	.section	.debug_abbrev,"dr"
.Ldebug_abbrev0:
	.uleb128 0x1
	.uleb128 0x11
	.byte	0x1
	.uleb128 0x25
	.uleb128 0x8
	.uleb128 0x13
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x1b
	.uleb128 0x8
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x10
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x2
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x8
	.byte	0
	.byte	0
	.uleb128 0x3
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x4
	.uleb128 0x35
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x5
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x6
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x7
	.uleb128 0x1
	.byte	0x1
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x8
	.uleb128 0x21
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x9
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0xa
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xb
	.uleb128 0x15
	.byte	0x1
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xc
	.uleb128 0x5
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xd
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xe
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0xf
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2116
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x10
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x11
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x12
	.uleb128 0x4109
	.byte	0
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x31
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x13
	.uleb128 0x2e
	.byte	0
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x6e
	.uleb128 0x8
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x14
	.uleb128 0x2e
	.byte	0
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x6e
	.uleb128 0xe
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_aranges,"dr"
	.long	0x2c
	.word	0x2
	.secrel32	.Ldebug_info0
	.byte	0x8
	.byte	0
	.word	0
	.word	0
	.quad	.Ltext0
	.quad	.Letext0-.Ltext0
	.quad	0
	.quad	0
	.section	.debug_line,"dr"
.Ldebug_line0:
	.section	.debug_str,"dr"
.LASF0:
	.ascii "__acrt_iob_func\0"
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	fprintf;	.scl	2;	.type	32;	.endef
	.def	pthread_mutex_lock;	.scl	2;	.type	32;	.endef
	.def	pthread_mutex_unlock;	.scl	2;	.type	32;	.endef
	.def	fwrite;	.scl	2;	.type	32;	.endef
	.def	pthread_mutex_init;	.scl	2;	.type	32;	.endef
	.def	puts;	.scl	2;	.type	32;	.endef
	.def	pthread_create;	.scl	2;	.type	32;	.endef
	.def	perror;	.scl	2;	.type	32;	.endef
	.def	exit;	.scl	2;	.type	32;	.endef
	.def	pthread_join;	.scl	2;	.type	32;	.endef
	.def	printf;	.scl	2;	.type	32;	.endef
