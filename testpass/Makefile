
C_SOURCES = $(wildcard *.c)
LLVM_ASMS = ${C_SOURCES:.c=.ll}
OBF_ASMS = ${LLVM_ASMS:.ll=.obf.ll}


.PHONY: all debug clean help
all: ${LLVM_ASMS} ${OBF_ASMS}

debug:
	@echo ${C_SOURCES}
	@echo ${LLVM_ASMS}
	@echo ${OBF_ASMS}

help:
	@opt -load ../build/myobf/libmyobf.so -h | grep -w -E -- "-hello|substitution"

clean:
	rm -rf ${LLVM_ASMS} ${OBF_ASMS}

%.ll: %.c
	clang -S -emit-llvm $^
# --substitution --sub_loop=2
%.obf.ll: %.ll
	opt -stats -S -load ../build/myobf/libmyobf.so --substitution --sub_loop=1 $^ -o $@

