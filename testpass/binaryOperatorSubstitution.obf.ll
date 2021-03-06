; ModuleID = 'binaryOperatorSubstitution.ll'
source_filename = "binaryOperatorSubstitution.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@x = dso_local global i64 4, align 8

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @add32(i32 %0) #0 {
  %2 = alloca i32, align 4
  store i32 %0, i32* %2, align 4
  %3 = load i32, i32* %2, align 4
  %4 = add i32 %3, 1580360740
  %5 = add i32 %4, 3
  %6 = sub i32 %5, 1580360740
  ret i32 %6
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @add64(i64 %0) #0 {
  %2 = alloca i64, align 8
  store i64 %0, i64* %2, align 8
  %3 = load i64, i64* %2, align 8
  %4 = add i64 %3, 3049192749
  %5 = add i64 %4, 3
  %6 = sub i64 %5, 3049192749
  ret i64 %6
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @and32(i32 %0) #0 {
  %2 = alloca i32, align 4
  store i32 %0, i32* %2, align 4
  %3 = load i32, i32* %2, align 4
  %4 = xor i32 5, -1
  %5 = xor i32 %3, %4
  %6 = and i32 %3, %5
  ret i32 %6
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @and64(i64 %0) #0 {
  %2 = alloca i64, align 8
  store i64 %0, i64* %2, align 8
  %3 = load i64, i64* %2, align 8
  %4 = xor i64 5, -1
  %5 = xor i64 %3, %4
  %6 = and i64 %3, %5
  ret i64 %6
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @or32(i32 %0) #0 {
  %2 = alloca i32, align 4
  store i32 %0, i32* %2, align 4
  %3 = load i32, i32* %2, align 4
  %4 = and i32 %3, 5
  %5 = xor i32 %3, 5
  %6 = or i32 %5, %4
  ret i32 %6
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @or64(i64 %0) #0 {
  %2 = alloca i64, align 8
  store i64 %0, i64* %2, align 8
  %3 = load i64, i64* %2, align 8
  %4 = and i64 %3, 5
  %5 = xor i64 %3, 5
  %6 = or i64 %5, %4
  ret i64 %6
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @xor32(i32 %0) #0 {
  %2 = alloca i32, align 4
  store i32 %0, i32* %2, align 4
  %3 = load i32, i32* %2, align 4
  %4 = xor i32 %3, -1
  %5 = xor i32 5, -1
  %6 = and i32 %4, 5
  %7 = and i32 %3, %5
  %8 = or i32 %6, %7
  ret i32 %8
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @xor64(i64 %0) #0 {
  %2 = alloca i64, align 8
  store i64 %0, i64* %2, align 8
  %3 = load i64, i64* %2, align 8
  %4 = xor i64 %3, -1
  %5 = xor i64 5, -1
  %6 = and i64 %4, 5
  %7 = and i64 %3, %5
  %8 = or i64 %6, %7
  ret i64 %8
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 10.0.0-4ubuntu1 "}
