; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.14.0"

%struct.timeval = type { i64, i32 }

@.str = private unnamed_addr constant [15 x i8] c"Bug! %d != %d\0A\00", align 1
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
  call void @llvm.lifetime.start.p0i8(i64 16, i8* nonnull %11) #7
  %12 = bitcast %struct.timeval* %4 to i8*
  call void @llvm.lifetime.start.p0i8(i64 16, i8* nonnull %12) #7
  tail call void @srand(i32 %7) #7
  %13 = call i32 @gettimeofday(%struct.timeval* nonnull %3, i8* null)
  %14 = icmp sgt i32 %10, 0
  br i1 %14, label %15, label %16

; <label>:15:                                     ; preds = %2
  br label %35

; <label>:16:                                     ; preds = %35, %2
  %17 = phi i32 [ 0, %2 ], [ %41, %35 ]
  %18 = call i32 @gettimeofday(%struct.timeval* nonnull %4, i8* null)
  %19 = getelementptr inbounds %struct.timeval, %struct.timeval* %4, i64 0, i32 0
  %20 = load i64, i64* %19, align 8, !tbaa !7
  %21 = getelementptr inbounds %struct.timeval, %struct.timeval* %4, i64 0, i32 1
  %22 = load i32, i32* %21, align 8, !tbaa !11
  %23 = sext i32 %22 to i64
  %24 = getelementptr inbounds %struct.timeval, %struct.timeval* %3, i64 0, i32 0
  %25 = load i64, i64* %24, align 8, !tbaa !7
  %26 = getelementptr inbounds %struct.timeval, %struct.timeval* %3, i64 0, i32 1
  %27 = load i32, i32* %26, align 8, !tbaa !11
  %28 = sext i32 %27 to i64
  %29 = sub i64 %20, %25
  %30 = mul i64 %29, 1000000
  %31 = sub nsw i64 %23, %28
  %32 = add i64 %31, %30
  tail call void @srand(i32 %7) #7
  %33 = call i32 @gettimeofday(%struct.timeval* nonnull %3, i8* null)
  br i1 %14, label %34, label %44

; <label>:34:                                     ; preds = %16
  br label %58

; <label>:35:                                     ; preds = %15, %35
  %36 = phi i32 [ %41, %35 ], [ 0, %15 ]
  %37 = phi i32 [ %42, %35 ], [ 0, %15 ]
  %38 = tail call i32 @rand() #7
  %39 = trunc i32 %38 to i16
  %40 = tail call fastcc i32 @ranges(i16 zeroext %39)
  %41 = add nsw i32 %40, %36
  %42 = add nuw nsw i32 %37, 1
  %43 = icmp eq i32 %42, %10
  br i1 %43, label %16, label %35

; <label>:44:                                     ; preds = %58, %16
  %45 = phi i32 [ 0, %16 ], [ %64, %58 ]
  %46 = call i32 @gettimeofday(%struct.timeval* nonnull %4, i8* null)
  %47 = load i64, i64* %19, align 8, !tbaa !7
  %48 = load i32, i32* %21, align 8, !tbaa !11
  %49 = sext i32 %48 to i64
  %50 = load i64, i64* %24, align 8, !tbaa !7
  %51 = load i32, i32* %26, align 8, !tbaa !11
  %52 = sext i32 %51 to i64
  %53 = sub i64 %47, %50
  %54 = mul i64 %53, 1000000
  %55 = sub nsw i64 %49, %52
  %56 = add i64 %55, %54
  %57 = icmp eq i32 %17, %45
  br i1 %57, label %69, label %67

; <label>:58:                                     ; preds = %34, %58
  %59 = phi i32 [ %65, %58 ], [ 0, %34 ]
  %60 = phi i32 [ %64, %58 ], [ 0, %34 ]
  %61 = tail call i32 @rand() #7
  %62 = trunc i32 %61 to i16
  %63 = tail call fastcc i32 @ranges2(i16 zeroext %62)
  %64 = add nsw i32 %63, %60
  %65 = add nuw nsw i32 %59, 1
  %66 = icmp eq i32 %65, %10
  br i1 %66, label %44, label %58

; <label>:67:                                     ; preds = %44
  %68 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([15 x i8], [15 x i8]* @.str, i64 0, i64 0), i32 %17, i32 %45)
  tail call void @exit(i32 0) #8
  unreachable

; <label>:69:                                     ; preds = %44
  %70 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([32 x i8], [32 x i8]* @.str.1, i64 0, i64 0), i64 %32)
  %71 = uitofp i64 %56 to double
  %72 = uitofp i64 %32 to double
  %73 = fdiv double %71, %72
  %74 = fadd double %73, -1.000000e+00
  %75 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([37 x i8], [37 x i8]* @.str.2, i64 0, i64 0), i64 %56, double %74)
  call void @llvm.lifetime.end.p0i8(i64 16, i8* nonnull %12) #7
  call void @llvm.lifetime.end.p0i8(i64 16, i8* nonnull %11) #7
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

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.end.p0i8(i64, i8* nocapture) #1

; Function Attrs: noinline norecurse nounwind readnone ssp uwtable
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

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) local_unnamed_addr #4

; Function Attrs: noreturn
declare void @exit(i32) local_unnamed_addr #6

attributes #0 = { noinline nounwind ssp uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="skylake" "target-features"="+adx,+aes,+avx,+avx2,+bmi,+bmi2,+clflushopt,+cmov,+cx16,+f16c,+fma,+fsgsbase,+fxsr,+lzcnt,+mmx,+movbe,+mpx,+pclmul,+popcnt,+prfchw,+rdrnd,+rdseed,+rtm,+sahf,+sgx,+sse,+sse2,+sse3,+sse4.1,+sse4.2,+ssse3,+x87,+xsave,+xsavec,+xsaveopt,+xsaves,-avx512bitalg,-avx512bw,-avx512cd,-avx512dq,-avx512er,-avx512f,-avx512ifma,-avx512pf,-avx512vbmi,-avx512vbmi2,-avx512vl,-avx512vnni,-avx512vpopcntdq,-clwb,-clzero,-fma4,-gfni,-ibt,-lwp,-mwaitx,-pku,-prefetchwt1,-sha,-shstk,-sse4a,-tbm,-vaes,-vpclmulqdq,-xop" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nounwind }
attributes #2 = { nounwind readonly "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="skylake" "target-features"="+adx,+aes,+avx,+avx2,+bmi,+bmi2,+clflushopt,+cmov,+cx16,+f16c,+fma,+fsgsbase,+fxsr,+lzcnt,+mmx,+movbe,+mpx,+pclmul,+popcnt,+prfchw,+rdrnd,+rdseed,+rtm,+sahf,+sgx,+sse,+sse2,+sse3,+sse4.1,+sse4.2,+ssse3,+x87,+xsave,+xsavec,+xsaveopt,+xsaves,-avx512bitalg,-avx512bw,-avx512cd,-avx512dq,-avx512er,-avx512f,-avx512ifma,-avx512pf,-avx512vbmi,-avx512vbmi2,-avx512vl,-avx512vnni,-avx512vpopcntdq,-clwb,-clzero,-fma4,-gfni,-ibt,-lwp,-mwaitx,-pku,-prefetchwt1,-sha,-shstk,-sse4a,-tbm,-vaes,-vpclmulqdq,-xop" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="skylake" "target-features"="+adx,+aes,+avx,+avx2,+bmi,+bmi2,+clflushopt,+cmov,+cx16,+f16c,+fma,+fsgsbase,+fxsr,+lzcnt,+mmx,+movbe,+mpx,+pclmul,+popcnt,+prfchw,+rdrnd,+rdseed,+rtm,+sahf,+sgx,+sse,+sse2,+sse3,+sse4.1,+sse4.2,+ssse3,+x87,+xsave,+xsavec,+xsaveopt,+xsaves,-avx512bitalg,-avx512bw,-avx512cd,-avx512dq,-avx512er,-avx512f,-avx512ifma,-avx512pf,-avx512vbmi,-avx512vbmi2,-avx512vl,-avx512vnni,-avx512vpopcntdq,-clwb,-clzero,-fma4,-gfni,-ibt,-lwp,-mwaitx,-pku,-prefetchwt1,-sha,-shstk,-sse4a,-tbm,-vaes,-vpclmulqdq,-xop" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="skylake" "target-features"="+adx,+aes,+avx,+avx2,+bmi,+bmi2,+clflushopt,+cmov,+cx16,+f16c,+fma,+fsgsbase,+fxsr,+lzcnt,+mmx,+movbe,+mpx,+pclmul,+popcnt,+prfchw,+rdrnd,+rdseed,+rtm,+sahf,+sgx,+sse,+sse2,+sse3,+sse4.1,+sse4.2,+ssse3,+x87,+xsave,+xsavec,+xsaveopt,+xsaves,-avx512bitalg,-avx512bw,-avx512cd,-avx512dq,-avx512er,-avx512f,-avx512ifma,-avx512pf,-avx512vbmi,-avx512vbmi2,-avx512vl,-avx512vnni,-avx512vpopcntdq,-clwb,-clzero,-fma4,-gfni,-ibt,-lwp,-mwaitx,-pku,-prefetchwt1,-sha,-shstk,-sse4a,-tbm,-vaes,-vpclmulqdq,-xop" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { noinline norecurse nounwind readnone ssp uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="skylake" "target-features"="+adx,+aes,+avx,+avx2,+bmi,+bmi2,+clflushopt,+cmov,+cx16,+f16c,+fma,+fsgsbase,+fxsr,+lzcnt,+mmx,+movbe,+mpx,+pclmul,+popcnt,+prfchw,+rdrnd,+rdseed,+rtm,+sahf,+sgx,+sse,+sse2,+sse3,+sse4.1,+sse4.2,+ssse3,+x87,+xsave,+xsavec,+xsaveopt,+xsaves,-avx512bitalg,-avx512bw,-avx512cd,-avx512dq,-avx512er,-avx512f,-avx512ifma,-avx512pf,-avx512vbmi,-avx512vbmi2,-avx512vl,-avx512vnni,-avx512vpopcntdq,-clwb,-clzero,-fma4,-gfni,-ibt,-lwp,-mwaitx,-pku,-prefetchwt1,-sha,-shstk,-sse4a,-tbm,-vaes,-vpclmulqdq,-xop" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #6 = { noreturn "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="skylake" "target-features"="+adx,+aes,+avx,+avx2,+bmi,+bmi2,+clflushopt,+cmov,+cx16,+f16c,+fma,+fsgsbase,+fxsr,+lzcnt,+mmx,+movbe,+mpx,+pclmul,+popcnt,+prfchw,+rdrnd,+rdseed,+rtm,+sahf,+sgx,+sse,+sse2,+sse3,+sse4.1,+sse4.2,+ssse3,+x87,+xsave,+xsavec,+xsaveopt,+xsaves,-avx512bitalg,-avx512bw,-avx512cd,-avx512dq,-avx512er,-avx512f,-avx512ifma,-avx512pf,-avx512vbmi,-avx512vbmi2,-avx512vl,-avx512vnni,-avx512vpopcntdq,-clwb,-clzero,-fma4,-gfni,-ibt,-lwp,-mwaitx,-pku,-prefetchwt1,-sha,-shstk,-sse4a,-tbm,-vaes,-vpclmulqdq,-xop" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #7 = { nounwind }
attributes #8 = { noreturn nounwind }

!llvm.module.flags = !{!0, !1}
!llvm.ident = !{!2}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!2 = !{!"Apple LLVM version 10.0.0 (clang-1000.11.45.5)"}
!3 = !{!4, !4, i64 0}
!4 = !{!"any pointer", !5, i64 0}
!5 = !{!"omnipotent char", !6, i64 0}
!6 = !{!"Simple C/C++ TBAA"}
!7 = !{!8, !9, i64 0}
!8 = !{!"timeval", !9, i64 0, !10, i64 8}
!9 = !{!"long", !5, i64 0}
!10 = !{!"int", !5, i64 0}
!11 = !{!8, !10, i64 8}
