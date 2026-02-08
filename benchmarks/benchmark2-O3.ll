; ModuleID = 'examples/recursive_fibonacci.c'
source_filename = "examples/recursive_fibonacci.c"
target datalayout = "e-m:w-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-windows-msvc19.50.35723"

$printf = comdat any

$__local_stdio_printf_options = comdat any

$"??_C@_0M@LDNOBAB@Result?3?5?$CFd?6?$AA@" = comdat any

@"??_C@_0M@LDNOBAB@Result?3?5?$CFd?6?$AA@" = linkonce_odr dso_local unnamed_addr constant [12 x i8] c"Result: %d\0A\00", comdat, align 1
@__local_stdio_printf_options._OptionsStorage = internal global i64 0, align 8

; Function Attrs: nofree nosync nounwind memory(none) uwtable
define dso_local i32 @fibonacci(i32 noundef %0) local_unnamed_addr #0 {
  %2 = icmp slt i32 %0, 2
  br i1 %2, label %11, label %3

3:                                                ; preds = %1, %3
  %4 = phi i32 [ %8, %3 ], [ %0, %1 ]
  %5 = phi i32 [ %9, %3 ], [ 0, %1 ]
  %6 = add nsw i32 %4, -1
  %7 = tail call i32 @fibonacci(i32 noundef %6)
  %8 = add nsw i32 %4, -2
  %9 = add nsw i32 %7, %5
  %10 = icmp samesign ult i32 %4, 4
  br i1 %10, label %11, label %3

11:                                               ; preds = %3, %1
  %12 = phi i32 [ 0, %1 ], [ %9, %3 ]
  %13 = phi i32 [ %0, %1 ], [ %8, %3 ]
  %14 = add nsw i32 %13, %12
  ret i32 %14
}

; Function Attrs: nounwind uwtable
define dso_local noundef i32 @main() local_unnamed_addr #1 {
  %1 = tail call i32 @fibonacci(i32 noundef 0)
  %2 = tail call i32 @fibonacci(i32 noundef 1)
  %3 = add nsw i32 %2, %1
  %4 = tail call i32 @fibonacci(i32 noundef 2)
  %5 = add nsw i32 %4, %3
  %6 = tail call i32 @fibonacci(i32 noundef 3)
  %7 = add nsw i32 %6, %5
  %8 = tail call i32 @fibonacci(i32 noundef 4)
  %9 = add nsw i32 %8, %7
  %10 = tail call i32 @fibonacci(i32 noundef 5)
  %11 = add nsw i32 %10, %9
  %12 = tail call i32 @fibonacci(i32 noundef 6)
  %13 = add nsw i32 %12, %11
  %14 = tail call i32 @fibonacci(i32 noundef 7)
  %15 = add nsw i32 %14, %13
  %16 = tail call i32 @fibonacci(i32 noundef 8)
  %17 = add nsw i32 %16, %15
  %18 = tail call i32 @fibonacci(i32 noundef 9)
  %19 = add nsw i32 %18, %17
  %20 = tail call i32 @fibonacci(i32 noundef 10)
  %21 = add nsw i32 %20, %19
  %22 = tail call i32 @fibonacci(i32 noundef 11)
  %23 = add nsw i32 %22, %21
  %24 = tail call i32 @fibonacci(i32 noundef 12)
  %25 = add nsw i32 %24, %23
  %26 = tail call i32 @fibonacci(i32 noundef 13)
  %27 = add nsw i32 %26, %25
  %28 = tail call i32 @fibonacci(i32 noundef 14)
  %29 = add nsw i32 %28, %27
  %30 = tail call i32 @fibonacci(i32 noundef 15)
  %31 = add nsw i32 %30, %29
  %32 = tail call i32 @fibonacci(i32 noundef 16)
  %33 = add nsw i32 %32, %31
  %34 = tail call i32 @fibonacci(i32 noundef 17)
  %35 = add nsw i32 %34, %33
  %36 = tail call i32 @fibonacci(i32 noundef 18)
  %37 = add nsw i32 %36, %35
  %38 = tail call i32 @fibonacci(i32 noundef 19)
  %39 = add nsw i32 %38, %37
  %40 = tail call i32 @fibonacci(i32 noundef 20)
  %41 = add nsw i32 %40, %39
  %42 = tail call i32 @fibonacci(i32 noundef 21)
  %43 = add nsw i32 %42, %41
  %44 = tail call i32 @fibonacci(i32 noundef 22)
  %45 = add nsw i32 %44, %43
  %46 = tail call i32 @fibonacci(i32 noundef 23)
  %47 = add nsw i32 %46, %45
  %48 = tail call i32 @fibonacci(i32 noundef 24)
  %49 = add nsw i32 %48, %47
  %50 = tail call i32 @fibonacci(i32 noundef 25)
  %51 = add nsw i32 %50, %49
  %52 = tail call i32 @fibonacci(i32 noundef 26)
  %53 = add nsw i32 %52, %51
  %54 = tail call i32 @fibonacci(i32 noundef 27)
  %55 = add nsw i32 %54, %53
  %56 = tail call i32 @fibonacci(i32 noundef 28)
  %57 = add nsw i32 %56, %55
  %58 = tail call i32 @fibonacci(i32 noundef 29)
  %59 = add nsw i32 %58, %57
  %60 = tail call i32 @fibonacci(i32 noundef 30)
  %61 = add nsw i32 %60, %59
  %62 = tail call i32 @fibonacci(i32 noundef 31)
  %63 = add nsw i32 %62, %61
  %64 = tail call i32 @fibonacci(i32 noundef 32)
  %65 = add nsw i32 %64, %63
  %66 = tail call i32 @fibonacci(i32 noundef 33)
  %67 = add nsw i32 %66, %65
  %68 = tail call i32 @fibonacci(i32 noundef 34)
  %69 = add nsw i32 %68, %67
  %70 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @"??_C@_0M@LDNOBAB@Result?3?5?$CFd?6?$AA@", i32 noundef %69)
  ret i32 0
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr captures(none)) #2

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr captures(none)) #2

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

attributes #0 = { nofree nosync nounwind memory(none) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #3 = { inlinehint nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { mustprogress nocallback nofree nosync nounwind willreturn }
attributes #5 = { noinline nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #6 = { "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #7 = { nounwind }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2, !3, !4, !5, !6}
!llvm.ident = !{!7}

!0 = distinct !DICompileUnit(language: DW_LANG_C11, file: !1, producer: "clang version 21.1.0", isOptimized: true, runtimeVersion: 0, emissionKind: NoDebug, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "examples\\recursive_fibonacci.c", directory: "C:\\Users\\user\\eureka-optimizer")
!2 = !{i32 2, !"Debug Info Version", i32 3}
!3 = !{i32 1, !"wchar_size", i32 2}
!4 = !{i32 8, !"PIC Level", i32 2}
!5 = !{i32 7, !"uwtable", i32 2}
!6 = !{i32 1, !"MaxTLSAlign", i32 65536}
!7 = !{!"clang version 21.1.0"}
