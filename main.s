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
	subq	$56, %rsp
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
## %bb.1:
	xorl	%r15d, %r15d
	movl	%r13d, %ebx
	.p2align	4, 0x90
LBB0_2:                                 ## =>This Inner Loop Header: Depth=1
	callq	_rand
	movzwl	%ax, %edi
	callq	_ranges
	addl	%eax, %r15d
	addl	$-1, %ebx
	jne	LBB0_2
LBB0_3:
	leaq	-64(%rbp), %rdi
	xorl	%esi, %esi
	callq	_gettimeofday
	movq	-64(%rbp), %rbx
	movslq	-56(%rbp), %r12
	movslq	-72(%rbp), %rax
	movq	%rax, -88(%rbp)         ## 8-byte Spill
	subq	-80(%rbp), %rbx
	movl	-44(%rbp), %edi         ## 4-byte Reload
	callq	_srand
	leaq	-80(%rbp), %rdi
	xorl	%esi, %esi
	callq	_gettimeofday
	testl	%r13d, %r13d
	jle	LBB0_6
## %bb.4:
	xorl	%r14d, %r14d
	.p2align	4, 0x90
LBB0_5:                                 ## =>This Inner Loop Header: Depth=1
	callq	_rand
	movzwl	%ax, %edi
	callq	_ranges2
	addl	%eax, %r14d
	addl	$-1, %r13d
	jne	LBB0_5
LBB0_6:
	leaq	-64(%rbp), %rdi
	xorl	%esi, %esi
	callq	_gettimeofday
	cmpl	%r14d, %r15d
	jne	LBB0_8
## %bb.7:
	imulq	$1000000, %rbx, %rax    ## imm = 0xF4240
	subq	-88(%rbp), %r12         ## 8-byte Folded Reload
	addq	%rax, %r12
	movq	-64(%rbp), %rax
	movslq	-56(%rbp), %rcx
	movslq	-72(%rbp), %rdx
	subq	%rdx, %rcx
	subq	-80(%rbp), %rax
	imulq	$1000000, %rax, %rbx    ## imm = 0xF4240
	addq	%rcx, %rbx
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
	addq	$56, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
LBB0_8:
	leaq	L_.str(%rip), %rdi
	xorl	%eax, %eax
	movl	%r15d, %esi
	movl	%r14d, %edx
	callq	_printf
	xorl	%edi, %edi
	callq	_exit
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
                                        ## kill: def $edi killed $edi def $rdi
	leal	-300(%rdi), %eax
	movzwl	%ax, %eax
	cmpl	$501, %eax              ## imm = 0x1F5
	setb	%al
	leal	-1100(%rdi), %ecx
	movzwl	%cx, %ecx
	cmpl	$601, %ecx              ## imm = 0x259
	setb	%cl
	orb	%al, %cl
	leal	-1900(%rdi), %eax
	movzwl	%ax, %eax
	cmpl	$201, %eax
	setb	%al
	leal	-2200(%rdi), %edx
	movzwl	%dx, %edx
	cmpl	$701, %edx              ## imm = 0x2BD
	setb	%dl
	orb	%al, %dl
	orb	%cl, %dl
	leal	-3100(%rdi), %eax
	movzwl	%ax, %eax
	cmpl	$201, %eax
	setb	%al
	leal	-4700(%rdi), %ecx
	movzwl	%cx, %ecx
	cmpl	$401, %ecx              ## imm = 0x191
	setb	%cl
	orb	%al, %cl
	leal	-5900(%rdi), %eax
	movzwl	%ax, %eax
	cmpl	$201, %eax
	setb	%al
	orb	%cl, %al
	orb	%dl, %al
	leal	-6800(%rdi), %ecx
	movzwl	%cx, %ecx
	cmpl	$1301, %ecx             ## imm = 0x515
	setb	%cl
	leal	-8400(%rdi), %edx
	movzwl	%dx, %edx
	cmpl	$901, %edx              ## imm = 0x385
	setb	%dl
	orb	%cl, %dl
	leal	-9500(%rdi), %ecx
	movzwl	%cx, %ecx
	cmpl	$201, %ecx
	setb	%cl
	orb	%dl, %cl
	leal	-9900(%rdi), %edx
	movzwl	%dx, %edx
	cmpl	$1801, %edx             ## imm = 0x709
	setb	%dl
	orb	%cl, %dl
	orb	%al, %dl
	leal	-12400(%rdi), %eax
	movzwl	%ax, %eax
	cmpl	$901, %eax              ## imm = 0x385
	setb	%al
	leal	-14200(%rdi), %ecx
	movzwl	%cx, %ecx
	cmpl	$2501, %ecx             ## imm = 0x9C5
	setb	%cl
	orb	%al, %cl
	leal	-18900(%rdi), %eax
	movzwl	%ax, %eax
	cmpl	$1001, %eax             ## imm = 0x3E9
	setb	%al
	orb	%cl, %al
	leal	-21100(%rdi), %ecx
	movzwl	%cx, %ecx
	cmpl	$3201, %ecx             ## imm = 0xC81
	setb	%cl
	orb	%al, %cl
	addl	$-24500, %edi           ## imm = 0xA04C
	movzwl	%di, %eax
	cmpl	$601, %eax              ## imm = 0x259
	setb	%al
	orb	%cl, %al
	orb	%dl, %al
	movzbl	%al, %eax
	andl	$1, %eax
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.section	__TEXT,__const
	.p2align	5               ## -- Begin function ranges2
LCPI2_0:
	.short	300                     ## 0x12c
	.short	1100                    ## 0x44c
	.short	1900                    ## 0x76c
	.short	2200                    ## 0x898
	.short	3100                    ## 0xc1c
	.short	4700                    ## 0x125c
	.short	5900                    ## 0x170c
	.short	6800                    ## 0x1a90
	.short	8400                    ## 0x20d0
	.short	9500                    ## 0x251c
	.short	9900                    ## 0x26ac
	.short	12400                   ## 0x3070
	.short	14200                   ## 0x3778
	.short	18900                   ## 0x49d4
	.short	21100                   ## 0x526c
	.short	24500                   ## 0x5fb4
LCPI2_1:
	.short	800                     ## 0x320
	.short	1700                    ## 0x6a4
	.short	2100                    ## 0x834
	.short	2900                    ## 0xb54
	.short	3300                    ## 0xce4
	.short	5100                    ## 0x13ec
	.short	6100                    ## 0x17d4
	.short	8100                    ## 0x1fa4
	.short	9300                    ## 0x2454
	.short	9700                    ## 0x25e4
	.short	11700                   ## 0x2db4
	.short	13300                   ## 0x33f4
	.short	16700                   ## 0x413c
	.short	19900                   ## 0x4dbc
	.short	24300                   ## 0x5eec
	.short	25100                   ## 0x620c
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
	vpbroadcastw	%xmm0, %ymm0
	vpmaxuw	LCPI2_0(%rip), %ymm0, %ymm1
	vpcmpeqw	%ymm1, %ymm0, %ymm1
	vextracti128	$1, %ymm1, %xmm2
	vpacksswb	%xmm2, %xmm1, %xmm1
	vpminuw	LCPI2_1(%rip), %ymm0, %ymm2
	vpcmpeqw	%ymm2, %ymm0, %ymm0
	vextracti128	$1, %ymm0, %xmm2
	vpacksswb	%xmm2, %xmm0, %xmm0
	vpand	%xmm0, %xmm1, %xmm0
	vpmovmskb	%xmm0, %ecx
	xorl	%eax, %eax
	testw	%cx, %cx
	setne	%al
	popq	%rbp
	vzeroupper
	retq
	.cfi_endproc
                                        ## -- End function
	.section	__TEXT,__cstring,cstring_literals
L_.str:                                 ## @.str
	.asciz	"Bug! %d != %d\n"

L_.str.1:                               ## @.str.1
	.asciz	"Compiler.............: %llu ms\n"

L_.str.2:                               ## @.str.2
	.asciz	"Hand-crafted LLVMIR..: %llu ms (%f)\n"


.subsections_via_symbols
