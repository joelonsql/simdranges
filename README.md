# simdranges
Just some PoC code to demonstrate the idea of using SIMD vector instructions
to do multiple range comparisons in parallel.

Consider the following C function:

```c
static int
ranges(uint8_t x)
{
  int y = 0;
  if (
      (x >= 3 && x <= 8) ||
      (x >= 11 && x <= 17) ||
      (x >= 19 && x <= 21) ||
      (x >= 22 && x <= 29) ||
      (x >= 31 && x <= 33) ||
      (x >= 47 && x <= 51) ||
      (x >= 59 && x <= 61) ||
      (x >= 68 && x <= 81) ||
      (x >= 84 && x <= 93) ||
      (x >= 95 && x <= 97) ||
      (x >= 99 && x <= 117) ||
      (x >= 124 && x <= 133) ||
      (x >= 142 && x <= 167) ||
      (x >= 189 && x <= 199) ||
      (x >= 211 && x <= 243) ||
      (x >= 245 && x <= 251))
  {
    y = 1;
  }
  return y;
}
```

Clang will produce this LLVMIR for this function:

```ll
; Function Attrs: noinline norecurse nounwind readnone ssp uwtable
define internal fastcc i32 @ranges(i8 zeroext) unnamed_addr #4 {
  %2 = add i8 %0, -3
  %3 = icmp ult i8 %2, 6
  %4 = add i8 %0, -11
  %5 = icmp ult i8 %4, 7
  %6 = or i1 %3, %5
  %7 = add i8 %0, -19
  %8 = icmp ult i8 %7, 3
  %9 = or i1 %8, %6
  %10 = add i8 %0, -22
  %11 = icmp ult i8 %10, 8
  %12 = or i1 %11, %9
  %13 = add i8 %0, -31
  %14 = icmp ult i8 %13, 3
  %15 = or i1 %14, %12
  %16 = add i8 %0, -47
  %17 = icmp ult i8 %16, 5
  %18 = or i1 %17, %15
  %19 = add i8 %0, -59
  %20 = icmp ult i8 %19, 3
  %21 = or i1 %20, %18
  %22 = add i8 %0, -68
  %23 = icmp ult i8 %22, 14
  %24 = or i1 %23, %21
  %25 = add i8 %0, -84
  %26 = icmp ult i8 %25, 10
  %27 = or i1 %26, %24
  %28 = add i8 %0, -95
  %29 = icmp ult i8 %28, 3
  %30 = or i1 %29, %27
  %31 = add i8 %0, -99
  %32 = icmp ult i8 %31, 19
  %33 = or i1 %32, %30
  %34 = add i8 %0, -124
  %35 = icmp ult i8 %34, 10
  %36 = or i1 %35, %33
  %37 = add i8 %0, 114
  %38 = icmp ult i8 %37, 26
  %39 = or i1 %38, %36
  %40 = add i8 %0, 67
  %41 = icmp ult i8 %40, 11
  %42 = or i1 %41, %39
  %43 = add i8 %0, 45
  %44 = icmp ult i8 %43, 33
  %45 = or i1 %44, %42
  %46 = add i8 %0, 11
  %47 = icmp ult i8 %46, 7
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
```

Can we manually do better? Yes we can!

Here is manually written LLVMIR for the same function:

```ll
define internal fastcc i32 @ranges2(i8 zeroext) unnamed_addr #2 {
; Load the same character(s) into a vector with same length
; as the number of ranges, e.g. 16 ranges in the example below:
  %q0 = insertelement <16 x i8> undef, i8 %0, i32 0
  %q1 = insertelement <16 x i8> %q0, i8 %0, i32 1
  %q2 = insertelement <16 x i8> %q1, i8 %0, i32 2
  %q3 = insertelement <16 x i8> %q2, i8 %0, i32 3
  %q4 = insertelement <16 x i8> %q3, i8 %0, i32 4
  %q5 = insertelement <16 x i8> %q4, i8 %0, i32 5
  %q6 = insertelement <16 x i8> %q5, i8 %0, i32 6
  %q7 = insertelement <16 x i8> %q6, i8 %0, i32 7
  %q8 = insertelement <16 x i8> %q7, i8 %0, i32 8
  %q9 = insertelement <16 x i8> %q8, i8 %0, i32 9
  %qa = insertelement <16 x i8> %q9, i8 %0, i32 10
  %qb = insertelement <16 x i8> %qa, i8 %0, i32 11
  %qc = insertelement <16 x i8> %qb, i8 %0, i32 12
  %qd = insertelement <16 x i8> %qc, i8 %0, i32 13
  %qe = insertelement <16 x i8> %qd, i8 %0, i32 14
  %qf = insertelement <16 x i8> %qe, i8 %0, i32 15

; Compare >= for each operand
  %gt = icmp uge <16 x i8> %qf, < i8 3, i8 11, i8 19, i8 22, i8 31, i8 47, i8 59, i8 68, i8 84, i8 95, i8 99, i8 124, i8 142, i8 189, i8 211, i8 245 >
; Compare <= for each operand
  %lt = icmp ule <16 x i8> %qf, < i8 8, i8 17, i8 21, i8 29, i8 33, i8 51, i8 61, i8 81, i8 93, i8 97, i8 117, i8 133, i8 167, i8 199, i8 243, i8 251 >
; Bit-wise and boolean vectors, if the character is within any range, one of them will be 1
  %tmp1 = and <16 x i1> %gt, %lt
; Cast vector of booleans to integer so that we can compare against 0
  %tmp2 = bitcast <16 x i1> %tmp1 to i16
; If it's not 0 that means character is within range
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

MacBook Pro 2,6 GHz Intel Core i7 (AVX2):

```asm
	vmovd	%edi, %xmm0
	vpbroadcastb	%xmm0, %xmm0
	vpmaxub	LCPI3_0(%rip), %xmm0, %xmm1
	vpcmpeqb	%xmm1, %xmm0, %xmm1
	vpminub	LCPI3_1(%rip), %xmm0, %xmm2
	vpcmpeqb	%xmm2, %xmm0, %xmm0
	vpand	%xmm0, %xmm1, %xmm0
	vpmovmskb	%xmm0, %ecx
	xorl	%eax, %eax
	testw	%cx, %cx
	setne	%al
	popq	%rbp
	retq
```

```sh
clang -O3 main.s && ./a.out 123 10000000

MacBook Pro 2,6 GHz Intel Core i7 (AVX2):

Compiler.............: 861524 ms
Hand-crafted LLVMIR..: 518396 ms (-0.398280)
```

39% speed-up! Human victory!