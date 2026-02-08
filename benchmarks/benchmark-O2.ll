; ModuleID = 'examples/iterative_fibonacci.c'
source_filename = "examples/iterative_fibonacci.c"
target datalayout = "e-m:w-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-windows-msvc19.50.35723"

$printf = comdat any

$__local_stdio_printf_options = comdat any

$"??_C@_0M@LDNOBAB@Result?3?5?$CFd?6?$AA@" = comdat any

@"??_C@_0M@LDNOBAB@Result?3?5?$CFd?6?$AA@" = linkonce_odr dso_local unnamed_addr constant [12 x i8] c"Result: %d\0A\00", comdat, align 1
@__local_stdio_printf_options._OptionsStorage = internal global i64 0, align 8

; Function Attrs: nofree norecurse nosync nounwind memory(none) uwtable
define dso_local i32 @fibonacci(i32 noundef %0) local_unnamed_addr #0 {
  %2 = icmp slt i32 %0, 2
  br i1 %2, label %36, label %3

3:                                                ; preds = %1
  %4 = add nsw i32 %0, -1
  %5 = add nsw i32 %0, -2
  %6 = and i32 %4, 7
  %7 = icmp ult i32 %5, 7
  br i1 %7, label %24, label %8

8:                                                ; preds = %3
  %9 = and i32 %4, -8
  br label %10

10:                                               ; preds = %10, %8
  %11 = phi i32 [ 1, %8 ], [ %21, %10 ]
  %12 = phi i32 [ 0, %8 ], [ %20, %10 ]
  %13 = phi i32 [ 0, %8 ], [ %22, %10 ]
  %14 = add nsw i32 %11, %12
  %15 = add nsw i32 %14, %11
  %16 = add nsw i32 %15, %14
  %17 = add nsw i32 %16, %15
  %18 = add nsw i32 %17, %16
  %19 = add nsw i32 %18, %17
  %20 = add nsw i32 %19, %18
  %21 = add nsw i32 %20, %19
  %22 = add i32 %13, 8
  %23 = icmp eq i32 %22, %9
  br i1 %23, label %24, label %10, !llvm.loop !8

24:                                               ; preds = %10, %3
  %25 = phi i32 [ poison, %3 ], [ %21, %10 ]
  %26 = phi i32 [ 1, %3 ], [ %21, %10 ]
  %27 = phi i32 [ 0, %3 ], [ %20, %10 ]
  %28 = icmp eq i32 %6, 0
  br i1 %28, label %36, label %29

29:                                               ; preds = %24, %29
  %30 = phi i32 [ %33, %29 ], [ %26, %24 ]
  %31 = phi i32 [ %30, %29 ], [ %27, %24 ]
  %32 = phi i32 [ %34, %29 ], [ 0, %24 ]
  %33 = add nsw i32 %30, %31
  %34 = add i32 %32, 1
  %35 = icmp eq i32 %34, %6
  br i1 %35, label %36, label %29, !llvm.loop !10

36:                                               ; preds = %24, %29, %1
  %37 = phi i32 [ %0, %1 ], [ %25, %24 ], [ %33, %29 ]
  ret i32 %37
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr captures(none)) #1

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr captures(none)) #1

; Function Attrs: nounwind uwtable
define dso_local noundef i32 @main() local_unnamed_addr #2 {
  br label %3

1:                                                ; preds = %45
  %2 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @"??_C@_0M@LDNOBAB@Result?3?5?$CFd?6?$AA@", i32 noundef %47)
  ret i32 0

3:                                                ; preds = %0, %45
  %4 = phi i32 [ 0, %0 ], [ %48, %45 ]
  %5 = phi i32 [ 0, %0 ], [ %47, %45 ]
  %6 = urem i32 %4, 30
  %7 = sub i32 %4, %6
  %8 = xor i32 %7, -1
  %9 = add i32 %4, %8
  %10 = urem i32 %4, 30
  %11 = icmp samesign ult i32 %10, 2
  br i1 %11, label %45, label %12

12:                                               ; preds = %3
  %13 = add i32 %4, -2
  %14 = sub i32 %13, %7
  %15 = and i32 %9, 7
  %16 = icmp ult i32 %14, 7
  br i1 %16, label %33, label %17

17:                                               ; preds = %12
  %18 = and i32 %9, -8
  br label %19

19:                                               ; preds = %19, %17
  %20 = phi i32 [ 1, %17 ], [ %30, %19 ]
  %21 = phi i32 [ 0, %17 ], [ %29, %19 ]
  %22 = phi i32 [ 0, %17 ], [ %31, %19 ]
  %23 = add nsw i32 %21, %20
  %24 = add nsw i32 %20, %23
  %25 = add nsw i32 %23, %24
  %26 = add nsw i32 %24, %25
  %27 = add nsw i32 %25, %26
  %28 = add nsw i32 %26, %27
  %29 = add nsw i32 %27, %28
  %30 = add nsw i32 %28, %29
  %31 = add i32 %22, 8
  %32 = icmp eq i32 %31, %18
  br i1 %32, label %33, label %19, !llvm.loop !8

33:                                               ; preds = %19, %12
  %34 = phi i32 [ poison, %12 ], [ %30, %19 ]
  %35 = phi i32 [ 1, %12 ], [ %30, %19 ]
  %36 = phi i32 [ 0, %12 ], [ %29, %19 ]
  %37 = icmp eq i32 %15, 0
  br i1 %37, label %45, label %38

38:                                               ; preds = %33, %38
  %39 = phi i32 [ %42, %38 ], [ %35, %33 ]
  %40 = phi i32 [ %39, %38 ], [ %36, %33 ]
  %41 = phi i32 [ %43, %38 ], [ 0, %33 ]
  %42 = add nsw i32 %40, %39
  %43 = add i32 %41, 1
  %44 = icmp eq i32 %43, %15
  br i1 %44, label %45, label %38, !llvm.loop !12

45:                                               ; preds = %33, %38, %3
  %46 = phi i32 [ %10, %3 ], [ %34, %33 ], [ %42, %38 ]
  %47 = add nsw i32 %46, %5
  %48 = add i32 %4, 1
  %49 = icmp eq i32 %48, 1000000
  br i1 %49, label %1, label %3, !llvm.loop !13
}

; Function Attrs: inlinehint nounwind uwtable
define linkonce_odr dso_local i32 @printf(ptr noundef %0, ...) local_unnamed_addr #3 comdat {
  %2 = alloca ptr, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %2) #7
  call void @llvm.va_start.p0(ptr nonnull %2)
  %3 = load ptr, ptr %2, align 8
  %4 = call ptr @__acrt_iob_func(i32 noundef 1) #7
  %5 = call ptr @__local_stdio_printf_options()
  %6 = load i64, ptr %5, align 8
  %7 = call i32 @__stdio_common_vfprintf(i64 noundef %6, ptr noundef %4, ptr noundef %0, ptr noundef null, ptr noundef %3) #7
  call void @llvm.va_end.p0(ptr nonnull %2)
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %2) #7
  ret i32 %7
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn
declare void @llvm.va_start.p0(ptr) #4

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn
declare void @llvm.va_end.p0(ptr) #4

; Function Attrs: noinline nounwind uwtable
define linkonce_odr dso_local ptr @__local_stdio_printf_options() local_unnamed_addr #5 comdat {
  ret ptr @__local_stdio_printf_options._OptionsStorage
}

declare dso_local ptr @__acrt_iob_func(i32 noundef) local_unnamed_addr #6

declare dso_local i32 @__stdio_common_vfprintf(i64 noundef, ptr noundef, ptr noundef, ptr noundef, ptr noundef) local_unnamed_addr #6

attributes #0 = { nofree norecurse nosync nounwind memory(none) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #2 = { nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { inlinehint nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { mustprogress nocallback nofree nosync nounwind willreturn }
attributes #5 = { noinline nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #6 = { "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #7 = { nounwind }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2, !3, !4, !5, !6}
!llvm.ident = !{!7}

!0 = distinct !DICompileUnit(language: DW_LANG_C11, file: !1, producer: "clang version 21.1.0", isOptimized: true, runtimeVersion: 0, emissionKind: NoDebug, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "examples\\iterative_fibonacci.c", directory: "C:\\Users\\user\\eureka-optimizer")
!2 = !{i32 2, !"Debug Info Version", i32 3}
!3 = !{i32 1, !"wchar_size", i32 2}
!4 = !{i32 8, !"PIC Level", i32 2}
!5 = !{i32 7, !"uwtable", i32 2}
!6 = !{i32 1, !"MaxTLSAlign", i32 65536}
!7 = !{!"clang version 21.1.0"}
!8 = distinct !{!8, !9}
!9 = !{!"llvm.loop.mustprogress"}
!10 = distinct !{!10, !11}
!11 = !{!"llvm.loop.unroll.disable"}
!12 = distinct !{!12, !11}
!13 = distinct !{!13, !9}
