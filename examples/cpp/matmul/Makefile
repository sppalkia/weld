CC=clang++
LDFLAGS=-L../../../target/debug/
LIBS=-lweld -lmkl_rt

.PHONY: all clean

all:
	#${CC} -O3 -march=native -lmkl_rt ${LDFLAGS} ${LIBS} matmul.cpp -o run
	/Users/shoumikpalkar/work/llvm/polly/llvm_build/bin/clang++ -O3 -march=native -mllvm -polly -mllvm -polly-vectorizer=stripmine ${LDFLAGS} ${LIBS} matmul.cpp -o run

clean:
	rm -rf run

