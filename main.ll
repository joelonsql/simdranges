; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.14.0"

%struct.timeval = type { i64, i32 }

@.str = private unnamed_addr constant [9 x i8] c"%d != %d\00", align 1
@.str.1 = private unnamed_addr constant [32 x i8] c"Compiler.............: %llu ms\0A\00", align 1
@.str.2 = private unnamed_addr constant [37 x i8] c"Hand-crafted LLVMIR..: %llu ms (%f)\0A\00", align 1

; Function Attrs: noinline nounwind ssp uwtable
define i32 @main(i32, i8** nocapture readonly) local_unnamed_addr #0 {
  %3 = alloca %struct.timeval, align 8
  %4 = alloca %struct.timeval, align 8
  %5 = getelementptr inbounds i8*, i8** %1, i64 1
  %6 = load i8*, i8** %5, align 8, !tbaa !3
  %7 = tail call i32 @atoi(i8* %6)
  %8 = getelementptr inbounds i8*, i8** %1, i64 2
  %9 = load i8*, i8** %8, align 8, !tbaa !3
  %10 = tail call i32 @atoi(i8* %9)
  %11 = bitcast %struct.timeval* %3 to i8*
  call void @llvm.lifetime.start.p0i8(i64 16, i8* nonnull %11) #6
  %12 = bitcast %struct.timeval* %4 to i8*
  call void @llvm.lifetime.start.p0i8(i64 16, i8* nonnull %12) #6
  tail call void @srand(i32 %7) #6
  %13 = call i32 @gettimeofday(%struct.timeval* nonnull %3, i8* null)
  %14 = icmp sgt i32 %10, 0
  br i1 %14, label %33, label %15

; <label>:15:                                     ; preds = %33, %2
  %16 = phi i32 [ 0, %2 ], [ %39, %33 ]
  %17 = call i32 @gettimeofday(%struct.timeval* nonnull %4, i8* null)
  %18 = getelementptr inbounds %struct.timeval, %struct.timeval* %4, i64 0, i32 0
  %19 = load i64, i64* %18, align 8, !tbaa !7
  %20 = getelementptr inbounds %struct.timeval, %struct.timeval* %4, i64 0, i32 1
  %21 = load i32, i32* %20, align 8, !tbaa !11
  %22 = sext i32 %21 to i64
  %23 = getelementptr inbounds %struct.timeval, %struct.timeval* %3, i64 0, i32 0
  %24 = load i64, i64* %23, align 8, !tbaa !7
  %25 = getelementptr inbounds %struct.timeval, %struct.timeval* %3, i64 0, i32 1
  %26 = load i32, i32* %25, align 8, !tbaa !11
  %27 = sext i32 %26 to i64
  %28 = sub i64 %19, %24
  %29 = mul i64 %28, 1000000
  %30 = sub nsw i64 %22, %27
  %31 = add i64 %30, %29
  tail call void @srand(i32 %7) #6
  %32 = call i32 @gettimeofday(%struct.timeval* nonnull %3, i8* null)
  br i1 %14, label %56, label %42

; <label>:33:                                     ; preds = %2, %33
  %34 = phi i32 [ %39, %33 ], [ 0, %2 ]
  %35 = phi i32 [ %40, %33 ], [ 0, %2 ]
  %36 = tail call i32 @rand() #6
  %37 = trunc i32 %36 to i8
  %38 = tail call fastcc i32 @ranges(i8 zeroext %37)
  %39 = add nsw i32 %38, %34
  %40 = add nuw nsw i32 %35, 1
  %41 = icmp eq i32 %40, %10
  br i1 %41, label %15, label %33

; <label>:42:                                     ; preds = %56, %15
  %43 = phi i32 [ 0, %15 ], [ %62, %56 ]
  %44 = call i32 @gettimeofday(%struct.timeval* nonnull %4, i8* null)
  %45 = load i64, i64* %18, align 8, !tbaa !7
  %46 = load i32, i32* %20, align 8, !tbaa !11
  %47 = sext i32 %46 to i64
  %48 = load i64, i64* %23, align 8, !tbaa !7
  %49 = load i32, i32* %25, align 8, !tbaa !11
  %50 = sext i32 %49 to i64
  %51 = sub i64 %45, %48
  %52 = mul i64 %51, 1000000
  %53 = sub nsw i64 %47, %50
  %54 = add i64 %53, %52
  %55 = icmp eq i32 %16, %43
  br i1 %55, label %67, label %65

; <label>:56:                                     ; preds = %15, %56
  %57 = phi i32 [ %63, %56 ], [ 0, %15 ]
  %58 = phi i32 [ %62, %56 ], [ 0, %15 ]
  %59 = tail call i32 @rand() #6
  %60 = trunc i32 %59 to i8
  %61 = tail call fastcc i32 @ranges2(i8 zeroext %60)
  %62 = add nsw i32 %61, %58
  %63 = add nuw nsw i32 %57, 1
  %64 = icmp eq i32 %63, %10
  br i1 %64, label %42, label %56

; <label>:65:                                     ; preds = %42
  %66 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str, i64 0, i64 0), i32 %16, i32 %43)
  br label %67

; <label>:67:                                     ; preds = %42, %65
  %68 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([32 x i8], [32 x i8]* @.str.1, i64 0, i64 0), i64 %31)
  %69 = uitofp i64 %54 to double
  %70 = uitofp i64 %31 to double
  %71 = fdiv double %69, %70
  %72 = fadd double %71, -1.000000e+00
  %73 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([37 x i8], [37 x i8]* @.str.2, i64 0, i64 0), i64 %54, double %72)
  call void @llvm.lifetime.end.p0i8(i64 16, i8* nonnull %12) #6
  call void @llvm.lifetime.end.p0i8(i64 16, i8* nonnull %11) #6
  ret i32 0
}

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.start.p0i8(i64, i8* nocapture) #1

; Function Attrs: nounwind readonly
declare i32 @atoi(i8* nocapture) local_unnamed_addr #2

declare void @srand(i32) local_unnamed_addr #3

; Function Attrs: nounwind
declare i32 @gettimeofday(%struct.timeval* nocapture, i8* nocapture) local_unnamed_addr #4

declare i32 @rand() local_unnamed_addr #3

; Function Attrs: noinline norecurse nounwind readnone ssp uwtable
define internal fastcc i32 @ranges(i8 zeroext) unnamed_addr #5 {
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

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.end.p0i8(i64, i8* nocapture) #1

; Function Attrs: noinline norecurse nounwind readnone ssp uwtable
define internal fastcc i32 @ranges2(i8 zeroext) unnamed_addr #5 {
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
  %gt = icmp uge <16 x i8> %qf, < i8 3, i8 11, i8 19, i8 22, i8 31, i8 47, i8 59, i8 68, i8 84, i8 95, i8 99, i8 124, i8 142, i8 189, i8 211, i8 245 >
  %lt = icmp ule <16 x i8> %qf, < i8 8, i8 17, i8 21, i8 29, i8 33, i8 51, i8 61, i8 81, i8 93, i8 97, i8 117, i8 133, i8 167, i8 199, i8 243, i8 251 >
  %tmp1 = and <16 x i1> %gt, %lt
  %tmp2 = bitcast <16 x i1> %tmp1 to i16
  %tmp3 = icmp ne i16 %tmp2, 0
  %ret = zext i1 %tmp3 to i32
  ret i32 %ret
}

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) local_unnamed_addr #4

attributes #0 = { noinline nounwind ssp uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="skylake" "target-features"="+adx,+aes,+avx,+avx2,+bmi,+bmi2,+clflushopt,+cmov,+cx16,+f16c,+fma,+fsgsbase,+fxsr,+invpcid,+lzcnt,+mmx,+movbe,+mpx,+pclmul,+popcnt,+prfchw,+rdrnd,+rdseed,+rtm,+sahf,+sgx,+sse,+sse2,+sse3,+sse4.1,+sse4.2,+ssse3,+x87,+xsave,+xsavec,+xsaveopt,+xsaves,-avx512bitalg,-avx512bw,-avx512cd,-avx512dq,-avx512er,-avx512f,-avx512ifma,-avx512pf,-avx512vbmi,-avx512vbmi2,-avx512vl,-avx512vnni,-avx512vpopcntdq,-cldemote,-clwb,-clzero,-fma4,-gfni,-lwp,-movdir64b,-movdiri,-mwaitx,-pconfig,-pku,-prefetchwt1,-ptwrite,-rdpid,-sha,-shstk,-sse4a,-tbm,-vaes,-vpclmulqdq,-waitpkg,-wbnoinvd,-xop" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nounwind }
attributes #2 = { nounwind readonly "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="skylake" "target-features"="+adx,+aes,+avx,+avx2,+bmi,+bmi2,+clflushopt,+cmov,+cx16,+f16c,+fma,+fsgsbase,+fxsr,+invpcid,+lzcnt,+mmx,+movbe,+mpx,+pclmul,+popcnt,+prfchw,+rdrnd,+rdseed,+rtm,+sahf,+sgx,+sse,+sse2,+sse3,+sse4.1,+sse4.2,+ssse3,+x87,+xsave,+xsavec,+xsaveopt,+xsaves,-avx512bitalg,-avx512bw,-avx512cd,-avx512dq,-avx512er,-avx512f,-avx512ifma,-avx512pf,-avx512vbmi,-avx512vbmi2,-avx512vl,-avx512vnni,-avx512vpopcntdq,-cldemote,-clwb,-clzero,-fma4,-gfni,-lwp,-movdir64b,-movdiri,-mwaitx,-pconfig,-pku,-prefetchwt1,-ptwrite,-rdpid,-sha,-shstk,-sse4a,-tbm,-vaes,-vpclmulqdq,-waitpkg,-wbnoinvd,-xop" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="skylake" "target-features"="+adx,+aes,+avx,+avx2,+bmi,+bmi2,+clflushopt,+cmov,+cx16,+f16c,+fma,+fsgsbase,+fxsr,+invpcid,+lzcnt,+mmx,+movbe,+mpx,+pclmul,+popcnt,+prfchw,+rdrnd,+rdseed,+rtm,+sahf,+sgx,+sse,+sse2,+sse3,+sse4.1,+sse4.2,+ssse3,+x87,+xsave,+xsavec,+xsaveopt,+xsaves,-avx512bitalg,-avx512bw,-avx512cd,-avx512dq,-avx512er,-avx512f,-avx512ifma,-avx512pf,-avx512vbmi,-avx512vbmi2,-avx512vl,-avx512vnni,-avx512vpopcntdq,-cldemote,-clwb,-clzero,-fma4,-gfni,-lwp,-movdir64b,-movdiri,-mwaitx,-pconfig,-pku,-prefetchwt1,-ptwrite,-rdpid,-sha,-shstk,-sse4a,-tbm,-vaes,-vpclmulqdq,-waitpkg,-wbnoinvd,-xop" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="skylake" "target-features"="+adx,+aes,+avx,+avx2,+bmi,+bmi2,+clflushopt,+cmov,+cx16,+f16c,+fma,+fsgsbase,+fxsr,+invpcid,+lzcnt,+mmx,+movbe,+mpx,+pclmul,+popcnt,+prfchw,+rdrnd,+rdseed,+rtm,+sahf,+sgx,+sse,+sse2,+sse3,+sse4.1,+sse4.2,+ssse3,+x87,+xsave,+xsavec,+xsaveopt,+xsaves,-avx512bitalg,-avx512bw,-avx512cd,-avx512dq,-avx512er,-avx512f,-avx512ifma,-avx512pf,-avx512vbmi,-avx512vbmi2,-avx512vl,-avx512vnni,-avx512vpopcntdq,-cldemote,-clwb,-clzero,-fma4,-gfni,-lwp,-movdir64b,-movdiri,-mwaitx,-pconfig,-pku,-prefetchwt1,-ptwrite,-rdpid,-sha,-shstk,-sse4a,-tbm,-vaes,-vpclmulqdq,-waitpkg,-wbnoinvd,-xop" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { noinline norecurse nounwind readnone ssp uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="skylake" "target-features"="+adx,+aes,+avx,+avx2,+bmi,+bmi2,+clflushopt,+cmov,+cx16,+f16c,+fma,+fsgsbase,+fxsr,+invpcid,+lzcnt,+mmx,+movbe,+mpx,+pclmul,+popcnt,+prfchw,+rdrnd,+rdseed,+rtm,+sahf,+sgx,+sse,+sse2,+sse3,+sse4.1,+sse4.2,+ssse3,+x87,+xsave,+xsavec,+xsaveopt,+xsaves,-avx512bitalg,-avx512bw,-avx512cd,-avx512dq,-avx512er,-avx512f,-avx512ifma,-avx512pf,-avx512vbmi,-avx512vbmi2,-avx512vl,-avx512vnni,-avx512vpopcntdq,-cldemote,-clwb,-clzero,-fma4,-gfni,-lwp,-movdir64b,-movdiri,-mwaitx,-pconfig,-pku,-prefetchwt1,-ptwrite,-rdpid,-sha,-shstk,-sse4a,-tbm,-vaes,-vpclmulqdq,-waitpkg,-wbnoinvd,-xop" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #6 = { nounwind }

!llvm.module.flags = !{!0, !1}
!llvm.ident = !{!2}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!2 = !{!"clang version 7.0.0 (tags/RELEASE_700/final)"}
!3 = !{!4, !4, i64 0}
!4 = !{!"any pointer", !5, i64 0}
!5 = !{!"omnipotent char", !6, i64 0}
!6 = !{!"Simple C/C++ TBAA"}
!7 = !{!8, !9, i64 0}
!8 = !{!"timeval", !9, i64 0, !10, i64 8}
!9 = !{!"long", !5, i64 0}
!10 = !{!"int", !5, i64 0}
!11 = !{!8, !10, i64 8}
