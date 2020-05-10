cobc -C -x -free hello.cob -o tmp/hello.c
rm /tmp/hello.c
mv tmp/hello.c /tmp/hello.c
cat say.c /tmp/hello.c > tmp/hello.c

clang -S -emit-llvm -o "./tmp/hello.bc" "tmp/hello.c"
clang  -o "hello" "./tmp/hello.bc" \
   -L/usr/local/lib -lcob -lm -lgmp -ldl