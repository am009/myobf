#!/bin/bash
# depricated
clang -Xclang -load -Xclang ../build/myobf/libmyobf.so $1.c -o $1
