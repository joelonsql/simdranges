# simdranges
Just some PoC code to demonstrate the idea of using SIMD vector instructions
to do multiple range comparisons in parallel.

Consider the following C function:

```c
static int
ranges(uint16_t x)
{
  int y = 0;
  if (
      (x >= 300 && x <= 800) ||
      (x >= 1100 && x <= 1700) ||
      (x >= 1900 && x <= 2100) ||
      (x >= 2200 && x <= 2900) ||
      (x >= 3100 && x <= 3300) ||
      (x >= 4700 && x <= 5100) ||
      (x >= 5900 && x <= 6100) ||
      (x >= 6800 && x <= 8100) ||
      (x >= 8400 && x <= 9300) ||
      (x >= 9500 && x <= 9700) ||
      (x >= 9900 && x <= 11700) ||
      (x >= 12400 && x <= 13300) ||
      (x >= 14200 && x <= 16700) ||
      (x >= 18900 && x <= 19900) ||
      (x >= 21100 && x <= 24300) ||
      (x >= 24500 && x <= 25100))
  {
    y = 1;
  }
  return y;
}
```

Clang will produce this LLVMIR for this function:

```ll
define internal fastcc i32 @ranges(i16 zeroext) unnamed_addr #5 {
  %2 = add i16 %0, -300
  %3 = icmp ult i16 %2, 501
  %4 = add i16 %0, -1100
  %5 = icmp ult i16 %4, 601
  %6 = or i1 %3, %5
  %7 = add i16 %0, -1900
  %8 = icmp ult i16 %7, 201
  %9 = or i1 %8, %6
  %10 = add i16 %0, -2200
  %11 = icmp ult i16 %10, 701
  %12 = or i1 %11, %9
  %13 = add i16 %0, -3100
  %14 = icmp ult i16 %13, 201
  %15 = or i1 %14, %12
  %16 = add i16 %0, -4700
  %17 = icmp ult i16 %16, 401
  %18 = or i1 %17, %15
  %19 = add i16 %0, -5900
  %20 = icmp ult i16 %19, 201
  %21 = or i1 %20, %18
  %22 = add i16 %0, -6800
  %23 = icmp ult i16 %22, 1301
  %24 = or i1 %23, %21
  %25 = add i16 %0, -8400
  %26 = icmp ult i16 %25, 901
  %27 = or i1 %26, %24
  %28 = add i16 %0, -9500
  %29 = icmp ult i16 %28, 201
  %30 = or i1 %29, %27
  %31 = add i16 %0, -9900
  %32 = icmp ult i16 %31, 1801
  %33 = or i1 %32, %30
  %34 = add i16 %0, -12400
  %35 = icmp ult i16 %34, 901
  %36 = or i1 %35, %33
  %37 = add i16 %0, -14200
  %38 = icmp ult i16 %37, 2501
  %39 = or i1 %38, %36
  %40 = add i16 %0, -18900
  %41 = icmp ult i16 %40, 1001
  %42 = or i1 %41, %39
  %43 = add i16 %0, -21100
  %44 = icmp ult i16 %43, 3201
  %45 = or i1 %44, %42
  %46 = add i16 %0, -24500
  %47 = icmp ult i16 %46, 601
  %48 = or i1 %47, %45
  %49 = zext i1 %48 to i32
  ret i32 %49
}
```

Which compiles to this assembly on x86-64 -O3 -march=native:
```asm
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
```

Can we manually do better? Yes we can!

Here is manually written LLVMIR for the same function:

```ll
define internal fastcc i32 @ranges2(i16 zeroext) unnamed_addr #5 {
  %q0 = insertelement <16 x i16> undef, i16 %0, i32 0
  %q1 = insertelement <16 x i16> %q0, i16 %0, i32 1
  %q2 = insertelement <16 x i16> %q1, i16 %0, i32 2
  %q3 = insertelement <16 x i16> %q2, i16 %0, i32 3
  %q4 = insertelement <16 x i16> %q3, i16 %0, i32 4
  %q5 = insertelement <16 x i16> %q4, i16 %0, i32 5
  %q6 = insertelement <16 x i16> %q5, i16 %0, i32 6
  %q7 = insertelement <16 x i16> %q6, i16 %0, i32 7
  %q8 = insertelement <16 x i16> %q7, i16 %0, i32 8
  %q9 = insertelement <16 x i16> %q8, i16 %0, i32 9
  %qa = insertelement <16 x i16> %q9, i16 %0, i32 10
  %qb = insertelement <16 x i16> %qa, i16 %0, i32 11
  %qc = insertelement <16 x i16> %qb, i16 %0, i32 12
  %qd = insertelement <16 x i16> %qc, i16 %0, i32 13
  %qe = insertelement <16 x i16> %qd, i16 %0, i32 14
  %qf = insertelement <16 x i16> %qe, i16 %0, i32 15
  %gt = icmp uge <16 x i16> %qf, < i16 300, i16 1100, i16 1900, i16 2200, i16 3100, i16 4700, i16 5900, i16 6800, i16 8400, i16 9500, i16 9900, i16 12400, i16 14200, i16 18900, i16 21100, i16 24500 >
  %lt = icmp ule <16 x i16> %qf, < i16 800, i16 1700, i16 2100, i16 2900, i16 3300, i16 5100, i16 6100, i16 8100, i16 9300, i16 9700, i16 11700, i16 13300, i16 16700, i16 19900, i16 24300, i16 25100 >
  %tmp1 = and <16 x i1> %gt, %lt
  %tmp2 = bitcast <16 x i1> %tmp1 to i16
  %tmp3 = icmp ne i16 %tmp2, 0
  %ret = zext i1 %tmp3 to i32
  ret i32 %ret
}
```

To start, produce the original main.ll which we will then manually edit:
```sh
clang -march=native -S -emit-llvm -O3 -fno-inline main.c
````

Then replaced ranges2() with the SIMD version above.

Compile LLVMIR to assembly:
```sh
llc -O3 main.ll
```

`main.s`

AVX2:

```asm
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
```

AVX-512:

```asm
	vpbroadcastw	%edi, %ymm0
	vpcmpnltuw	LCPI2_0(%rip), %ymm0, %k1
	vpcmpleuw	LCPI2_1(%rip), %ymm0, %k0 {%k1}
	xorl	%eax, %eax
	kortestw	%k0, %k0
	setne	%al
	popq	%rbp
	vzeroupper
	retq
```

```sh
clang -march=native -O3 main.s && ./a.out 123 100000000

MacBook Pro 2,6 GHz Intel Core i7 (AVX2):
Compiler.............: 998832 ms
Hand-crafted LLVMIR..: 528809 ms (-0.470573)
```

47% speed-up! Human victory!

