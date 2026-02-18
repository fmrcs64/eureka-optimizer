; ModuleID = 'examples/iterative_fibonacci.c'
source_filename = "examples/iterative_fibonacci.c"
target datalayout = "e-m:w-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-windows-msvc19.44.35222"

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
  br i1 %23, label %24, label %10, !llvm.loop !5

24:                                               ; preds = %10, %3
  %25 = phi i32 [ undef, %3 ], [ %21, %10 ]
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
  br i1 %35, label %36, label %29, !llvm.loop !7

36:                                               ; preds = %24, %29, %1
  %37 = phi i32 [ %0, %1 ], [ %25, %24 ], [ %33, %29 ]
  ret i32 %37
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: nounwind uwtable
define dso_local noundef i32 @main() local_unnamed_addr #2 {
  br label %3

1:                                                ; preds = %15
  %2 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @"??_C@_0M@LDNOBAB@Result?3?5?$CFd?6?$AA@", i32 noundef %17)
  ret i32 0

3:                                                ; preds = %0, %15
  %4 = phi i32 [ 0, %0 ], [ %18, %15 ]
  %5 = phi i32 [ 0, %0 ], [ %17, %15 ]
  %6 = urem i32 %4, 30
  %7 = icmp ult i32 %6, 2
  br i1 %7, label %15, label %8

8:                                                ; preds = %3, %8
  %9 = phi i32 [ %13, %8 ], [ 2, %3 ]
  %10 = phi i32 [ %12, %8 ], [ 1, %3 ]
  %11 = phi i32 [ %10, %8 ], [ 0, %3 ]
  %12 = add nsw i32 %11, %10
  %13 = add nuw i32 %9, 1
  %14 = icmp eq i32 %9, %6
  br i1 %14, label %15, label %8, !llvm.loop !5

15:                                               ; preds = %8, %3
  %16 = phi i32 [ %6, %3 ], [ %12, %8 ]
  %17 = add nsw i32 %16, %5
  %18 = add nuw nsw i32 %4, 1
  %19 = icmp eq i32 %18, 1000000
  br i1 %19, label %1, label %3, !llvm.loop !9
}

; Function Attrs: inlinehint nounwind uwtable
define linkonce_odr dso_local i32 @printf(ptr noundef %0, ...) local_unnamed_addr #3 comdat {
  %2 = alloca ptr, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %2) #7
  call void @llvm.va_start(ptr nonnull %2)
  %3 = load ptr, ptr %2, align 8, !tbaa !10
  %4 = call ptr @__acrt_iob_func(i32 noundef 1) #7
  %5 = call ptr @__local_stdio_printf_options()
  %6 = load i64, ptr %5, align 8, !tbaa !14
  %7 = call i32 @__stdio_common_vfprintf(i64 noundef %6, ptr noundef %4, ptr noundef %0, ptr noundef null, ptr noundef %3) #7
  call void @llvm.va_end(ptr nonnull %2)
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %2) #7
  ret i32 %7
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn
declare void @llvm.va_start(ptr) #4

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn
declare void @llvm.va_end(ptr) #4

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

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}

!0 = !{i32 1, !"wchar_size", i32 2}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"uwtable", i32 2}
!3 = !{i32 1, !"MaxTLSAlign", i32 65536}
!4 = !{!"clang version 18.1.1 (https://github.com/llvm/llvm-project.git dba2a75e9c7ef81fe84774ba5eee5e67e01d801a)"}
!5 = distinct !{!5, !6}
!6 = !{!"llvm.loop.mustprogress"}
!7 = distinct !{!7, !8}
!8 = !{!"llvm.loop.unroll.disable"}
!9 = distinct !{!9, !6}
!10 = !{!11, !11, i64 0}
!11 = !{!"any pointer", !12, i64 0}
!12 = !{!"omnipotent char", !13, i64 0}
!13 = !{!"Simple C/C++ TBAA"}
!14 = !{!15, !15, i64 0}
!15 = !{!"long long", !12, i64 0}
