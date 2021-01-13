; ModuleID = 'Annotation.c'
source_filename = "Annotation.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@a = dso_local global i32 3, align 4, !dbg !0
@.str = private unnamed_addr constant [7 x i8] c"hello1\00", section "llvm.metadata"
@.str.1 = private unnamed_addr constant [13 x i8] c"Annotation.c\00", section "llvm.metadata"
@.str.2 = private unnamed_addr constant [7 x i8] c"hello2\00", section "llvm.metadata"
@.str.3 = private unnamed_addr constant [6 x i8] c"hello\00", section "llvm.metadata"
@.str.4 = private unnamed_addr constant [6 x i8] c"twice\00", section "llvm.metadata"
@.str.5 = private unnamed_addr constant [3 x i8] c"ha\00", section "llvm.metadata"
@llvm.global.annotations = appending global [3 x { i8*, i8*, i8*, i32 }] [{ i8*, i8*, i8*, i32 } { i8* bitcast (i32* @a to i8*), i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str, i32 0, i32 0), i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.1, i32 0, i32 0), i32 3 }, { i8*, i8*, i8*, i32 } { i8* bitcast (i32 (i32)* @d to i8*), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.3, i32 0, i32 0), i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.1, i32 0, i32 0), i32 10 }, { i8*, i8*, i8*, i32 } { i8* bitcast (i32 (i32)* @d to i8*), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.4, i32 0, i32 0), i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.1, i32 0, i32 0), i32 10 }], section "llvm.metadata"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @b(i32 %0) #0 !dbg !11 {
  %2 = alloca i32, align 4
  store i32 %0, i32* %2, align 4
  call void @llvm.dbg.declare(metadata i32* %2, metadata !14, metadata !DIExpression()), !dbg !15
  %3 = bitcast i32* %2 to i8*
  call void @llvm.var.annotation(i8* %3, i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.2, i32 0, i32 0), i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.1, i32 0, i32 0), i32 5)
  %4 = load i32, i32* %2, align 4, !dbg !16
  %5 = add nsw i32 %4, 41, !dbg !17
  ret i32 %5, !dbg !18
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: nounwind willreturn
declare void @llvm.var.annotation(i8*, i8*, i8*, i32) #2

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @d(i32 %0) #0 !dbg !19 {
  %2 = alloca i32, align 4
  store i32 %0, i32* %2, align 4
  call void @llvm.dbg.declare(metadata i32* %2, metadata !20, metadata !DIExpression()), !dbg !21
  %3 = load i32, i32* %2, align 4, !dbg !22
  %4 = add nsw i32 %3, 42, !dbg !23
  ret i32 %4, !dbg !24
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @e() #0 !dbg !25 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = load i32, i32* @a, align 4, !dbg !28
  %5 = icmp ne i32 %4, 0, !dbg !28
  br i1 %5, label %6, label %16, !dbg !30

6:                                                ; preds = %0
  call void @llvm.dbg.declare(metadata i32* %2, metadata !31, metadata !DIExpression()), !dbg !33
  %7 = bitcast i32* %2 to i8*, !dbg !34
  call void @llvm.var.annotation(i8* %7, i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.5, i32 0, i32 0), i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.1, i32 0, i32 0), i32 20), !dbg !34
  %8 = load i32, i32* @a, align 4, !dbg !35
  store i32 %8, i32* %2, align 4, !dbg !33
  %9 = load i32, i32* %2, align 4, !dbg !36
  %10 = add nsw i32 %9, 1, !dbg !38
  %11 = icmp ne i32 %10, 0, !dbg !38
  br i1 %11, label %12, label %15, !dbg !39

12:                                               ; preds = %6
  call void @llvm.dbg.declare(metadata i32* %3, metadata !40, metadata !DIExpression()), !dbg !42
  %13 = bitcast i32* %3 to i8*, !dbg !43
  call void @llvm.var.annotation(i8* %13, i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.5, i32 0, i32 0), i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.1, i32 0, i32 0), i32 23), !dbg !43
  %14 = load i32, i32* %2, align 4, !dbg !44
  store i32 %14, i32* %3, align 4, !dbg !42
  store i32 3, i32* %1, align 4, !dbg !45
  br label %17, !dbg !45

15:                                               ; preds = %6
  br label %16, !dbg !46

16:                                               ; preds = %15, %0
  store i32 0, i32* %1, align 4, !dbg !47
  br label %17, !dbg !47

17:                                               ; preds = %16, %12
  %18 = load i32, i32* %1, align 4, !dbg !48
  ret i32 %18, !dbg !48
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable willreturn }
attributes #2 = { nounwind willreturn }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!7, !8, !9}
!llvm.ident = !{!10}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "a", scope: !2, file: !3, line: 3, type: !6, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 10.0.0-4ubuntu1 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, globals: !5, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "Annotation.c", directory: "/home/wjk/llvm/llvm-pass-tutorial/testpass/Annotation")
!4 = !{}
!5 = !{!0}
!6 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!7 = !{i32 7, !"Dwarf Version", i32 4}
!8 = !{i32 2, !"Debug Info Version", i32 3}
!9 = !{i32 1, !"wchar_size", i32 4}
!10 = !{!"clang version 10.0.0-4ubuntu1 "}
!11 = distinct !DISubprogram(name: "b", scope: !3, file: !3, line: 5, type: !12, scopeLine: 6, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!12 = !DISubroutineType(types: !13)
!13 = !{!6, !6}
!14 = !DILocalVariable(name: "c", arg: 1, scope: !11, file: !3, line: 5, type: !6)
!15 = !DILocation(line: 5, column: 49, scope: !11)
!16 = !DILocation(line: 7, column: 10, scope: !11)
!17 = !DILocation(line: 7, column: 12, scope: !11)
!18 = !DILocation(line: 7, column: 3, scope: !11)
!19 = distinct !DISubprogram(name: "d", scope: !3, file: !3, line: 10, type: !12, scopeLine: 11, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!20 = !DILocalVariable(name: "e", arg: 1, scope: !19, file: !3, line: 10, type: !6)
!21 = !DILocation(line: 10, column: 11, scope: !19)
!22 = !DILocation(line: 12, column: 10, scope: !19)
!23 = !DILocation(line: 12, column: 12, scope: !19)
!24 = !DILocation(line: 12, column: 3, scope: !19)
!25 = distinct !DISubprogram(name: "e", scope: !3, file: !3, line: 15, type: !26, scopeLine: 16, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!26 = !DISubroutineType(types: !27)
!27 = !{!6}
!28 = !DILocation(line: 18, column: 7, scope: !29)
!29 = distinct !DILexicalBlock(scope: !25, file: !3, line: 18, column: 7)
!30 = !DILocation(line: 18, column: 7, scope: !25)
!31 = !DILocalVariable(name: "aa", scope: !32, file: !3, line: 20, type: !6)
!32 = distinct !DILexicalBlock(scope: !29, file: !3, line: 19, column: 3)
!33 = !DILocation(line: 20, column: 9, scope: !32)
!34 = !DILocation(line: 20, column: 5, scope: !32)
!35 = !DILocation(line: 20, column: 48, scope: !32)
!36 = !DILocation(line: 21, column: 9, scope: !37)
!37 = distinct !DILexicalBlock(scope: !32, file: !3, line: 21, column: 9)
!38 = !DILocation(line: 21, column: 12, scope: !37)
!39 = !DILocation(line: 21, column: 9, scope: !32)
!40 = !DILocalVariable(name: "b", scope: !41, file: !3, line: 23, type: !6)
!41 = distinct !DILexicalBlock(scope: !37, file: !3, line: 22, column: 5)
!42 = !DILocation(line: 23, column: 11, scope: !41)
!43 = !DILocation(line: 23, column: 7, scope: !41)
!44 = !DILocation(line: 23, column: 49, scope: !41)
!45 = !DILocation(line: 24, column: 7, scope: !41)
!46 = !DILocation(line: 26, column: 3, scope: !32)
!47 = !DILocation(line: 27, column: 3, scope: !25)
!48 = !DILocation(line: 28, column: 1, scope: !25)
