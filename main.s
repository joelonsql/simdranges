	.section	__TEXT,__text,regular,pure_instructions
	.macosx_version_min 10, 14
	.section	__TEXT,__literal16,16byte_literals
	.p2align	4               ## -- Begin function main
LCPI0_0:
	.long	1127219200              ## 0x43300000
	.long	1160773632              ## 0x45300000
	.long	0                       ## 0x0
	.long	0                       ## 0x0
LCPI0_1:
	.quad	4841369599423283200     ## double 4503599627370496
	.quad	4985484787499139072     ## double 1.9342813113834067E+25
	.section	__TEXT,__literal8,8byte_literals
	.p2align	3
LCPI0_2:
	.quad	-4616189618054758400    ## double -1
	.section	__TEXT,__text,regular,pure_instructions
	.globl	_main
	.p2align	4, 0x90
_main:                                  ## @main
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$40, %rsp
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	movq	%rsi, %rbx
	movq	8(%rsi), %rdi
	callq	_atoi
	movl	%eax, %r14d
	movq	16(%rbx), %rdi
	callq	_atoi
	movl	%eax, %r13d
	movl	%r14d, -44(%rbp)        ## 4-byte Spill
	movl	%r14d, %edi
	callq	_srand
	xorl	%r14d, %r14d
	leaq	-80(%rbp), %rdi
	xorl	%esi, %esi
	callq	_gettimeofday
	movl	$0, %r15d
	testl	%r13d, %r13d
	jle	LBB0_3
## %bb.1:                               ## %.preheader1
	xorl	%r15d, %r15d
	movl	%r13d, %ebx
	.p2align	4, 0x90
LBB0_2:                                 ## =>This Inner Loop Header: Depth=1
	callq	_rand
	movzbl	%al, %edi
	callq	_ranges
	addl	%eax, %r15d
	addl	$-1, %ebx
	jne	LBB0_2
LBB0_3:
	leaq	-64(%rbp), %rdi
	xorl	%esi, %esi
	callq	_gettimeofday
	movq	-64(%rbp), %rax
	movslq	-56(%rbp), %r12
	movslq	-72(%rbp), %rcx
	subq	%rcx, %r12
	subq	-80(%rbp), %rax
	imulq	$1000000, %rax, %rbx    ## imm = 0xF4240
	movl	-44(%rbp), %edi         ## 4-byte Reload
	callq	_srand
	leaq	-80(%rbp), %rdi
	xorl	%esi, %esi
	callq	_gettimeofday
	testl	%r13d, %r13d
	jle	LBB0_6
## %bb.4:                               ## %.preheader
	xorl	%r14d, %r14d
	.p2align	4, 0x90
LBB0_5:                                 ## =>This Inner Loop Header: Depth=1
	callq	_rand
	movzbl	%al, %edi
	callq	_ranges2
	addl	%eax, %r14d
	addl	$-1, %r13d
	jne	LBB0_5
LBB0_6:
	addq	%rbx, %r12
	leaq	-64(%rbp), %rdi
	xorl	%esi, %esi
	callq	_gettimeofday
	movq	-64(%rbp), %rax
	movslq	-56(%rbp), %rcx
	movslq	-72(%rbp), %rdx
	subq	%rdx, %rcx
	subq	-80(%rbp), %rax
	imulq	$1000000, %rax, %rbx    ## imm = 0xF4240
	addq	%rcx, %rbx
	cmpl	%r14d, %r15d
	je	LBB0_8
## %bb.7:
	leaq	L_.str(%rip), %rdi
	xorl	%eax, %eax
	movl	%r15d, %esi
	movl	%r14d, %edx
	callq	_printf
LBB0_8:
	leaq	L_.str.1(%rip), %rdi
	xorl	%eax, %eax
	movq	%r12, %rsi
	callq	_printf
	vmovq	%rbx, %xmm0
	vmovdqa	LCPI0_0(%rip), %xmm1    ## xmm1 = [1127219200,1160773632,0,0]
	vpunpckldq	%xmm1, %xmm0, %xmm0 ## xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1]
	vmovapd	LCPI0_1(%rip), %xmm2    ## xmm2 = [4.503600e+15,1.934281e+25]
	vsubpd	%xmm2, %xmm0, %xmm0
	vhaddpd	%xmm0, %xmm0, %xmm0
	vmovq	%r12, %xmm3
	vpunpckldq	%xmm1, %xmm3, %xmm1 ## xmm1 = xmm3[0],xmm1[0],xmm3[1],xmm1[1]
	vsubpd	%xmm2, %xmm1, %xmm1
	vhaddpd	%xmm1, %xmm1, %xmm1
	vdivsd	%xmm1, %xmm0, %xmm0
	vaddsd	LCPI0_2(%rip), %xmm0, %xmm0
	leaq	L_.str.2(%rip), %rdi
	movb	$1, %al
	movq	%rbx, %rsi
	callq	_printf
	xorl	%eax, %eax
	addq	$40, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.p2align	4, 0x90         ## -- Begin function ranges
_ranges:                                ## @ranges
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movl	%edi, %eax
	addb	$-3, %al
	cmpb	$6, %al
	setb	%al
	movl	%edi, %ecx
	addb	$-11, %cl
	cmpb	$7, %cl
	setb	%cl
	orb	%al, %cl
	movl	%edi, %eax
	addb	$-19, %al
	cmpb	$3, %al
	setb	%al
	movl	%edi, %edx
	addb	$-22, %dl
	cmpb	$8, %dl
	setb	%dl
	orb	%al, %dl
	orb	%cl, %dl
	movl	%edi, %eax
	addb	$-31, %al
	cmpb	$3, %al
	setb	%al
	movl	%edi, %ecx
	addb	$-47, %cl
	cmpb	$5, %cl
	setb	%cl
	orb	%al, %cl
	movl	%edi, %eax
	addb	$-59, %al
	cmpb	$3, %al
	setb	%al
	orb	%cl, %al
	orb	%dl, %al
	movl	%edi, %ecx
	addb	$-68, %cl
	cmpb	$14, %cl
	setb	%cl
	movl	%edi, %edx
	addb	$-84, %dl
	cmpb	$10, %dl
	setb	%dl
	orb	%cl, %dl
	movl	%edi, %ecx
	addb	$-95, %cl
	cmpb	$3, %cl
	setb	%cl
	orb	%dl, %cl
	movl	%edi, %edx
	addb	$-99, %dl
	cmpb	$19, %dl
	setb	%dl
	orb	%cl, %dl
	orb	%al, %dl
	movl	%edi, %eax
	addb	$-124, %al
	cmpb	$10, %al
	setb	%al
	movl	%edi, %ecx
	addb	$114, %cl
	cmpb	$26, %cl
	setb	%cl
	orb	%al, %cl
	movl	%edi, %eax
	addb	$67, %al
	cmpb	$11, %al
	setb	%al
	orb	%cl, %al
	movl	%edi, %ecx
	addb	$45, %cl
	cmpb	$33, %cl
	setb	%cl
	orb	%al, %cl
	addb	$11, %dil
	cmpb	$7, %dil
	setb	%al
	orb	%cl, %al
	orb	%dl, %al
	movzbl	%al, %eax
	andl	$1, %eax
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.section	__TEXT,__literal16,16byte_literals
	.p2align	4               ## -- Begin function ranges2
LCPI2_0:
	.byte	3                       ## 0x3
	.byte	11                      ## 0xb
	.byte	19                      ## 0x13
	.byte	22                      ## 0x16
	.byte	31                      ## 0x1f
	.byte	47                      ## 0x2f
	.byte	59                      ## 0x3b
	.byte	68                      ## 0x44
	.byte	84                      ## 0x54
	.byte	95                      ## 0x5f
	.byte	99                      ## 0x63
	.byte	124                     ## 0x7c
	.byte	142                     ## 0x8e
	.byte	189                     ## 0xbd
	.byte	211                     ## 0xd3
	.byte	245                     ## 0xf5
LCPI2_1:
	.byte	8                       ## 0x8
	.byte	17                      ## 0x11
	.byte	21                      ## 0x15
	.byte	29                      ## 0x1d
	.byte	33                      ## 0x21
	.byte	51                      ## 0x33
	.byte	61                      ## 0x3d
	.byte	81                      ## 0x51
	.byte	93                      ## 0x5d
	.byte	97                      ## 0x61
	.byte	117                     ## 0x75
	.byte	133                     ## 0x85
	.byte	167                     ## 0xa7
	.byte	199                     ## 0xc7
	.byte	243                     ## 0xf3
	.byte	251                     ## 0xfb
	.section	__TEXT,__text,regular,pure_instructions
	.p2align	4, 0x90
_ranges2:                               ## @ranges2
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	vmovd	%edi, %xmm0
	vpbroadcastb	%xmm0, %xmm0
	vpmaxub	LCPI2_0(%rip), %xmm0, %xmm1
	vpcmpeqb	%xmm1, %xmm0, %xmm1
	vpminub	LCPI2_1(%rip), %xmm0, %xmm2
	vpcmpeqb	%xmm2, %xmm0, %xmm0
	vpand	%xmm0, %xmm1, %xmm0
	vpmovmskb	%xmm0, %ecx
	xorl	%eax, %eax
	testw	%cx, %cx
	setne	%al
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.section	__TEXT,__cstring,cstring_literals
L_.str:                                 ## @.str
	.asciz	"%d != %d"

L_.str.1:                               ## @.str.1
	.asciz	"Compiler.............: %llu ms\n"

L_.str.2:                               ## @.str.2
	.asciz	"Hand-crafted LLVMIR..: %llu ms (%f)\n"


.subsections_via_symbols
