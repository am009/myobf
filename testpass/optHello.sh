#!/bin/bash
# depricated
clang -c -emit-llvm $1.c
opt -load ../build/skeleton/libSkeletonPass.so -hello < $1.bc > $1.out.bc
clang $1.out.bc -o $1
llvm-dis $1.bc
llvm-dis $1.out.bc