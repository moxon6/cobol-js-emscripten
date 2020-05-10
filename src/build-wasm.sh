mkdir -p tmp
mkdir -p out

cobc -C -x -free helloworld.cob -o tmp/hello.c
sed -i '/cobol_emscripten_sleep.funcvoid/c\' tmp/hello.c
sed -i '/cobol_emscripten_sleep.funcint/c\emscripten_sleep(20);' tmp/hello.c

emcc -o out/hello.html tmp/hello.c \
  /root/opt/lib/*.a -I/root/opt/include \
  -I/workspaces/cobol-wasm-hello-world/gnucobol-3.0-rc1 -s FORCE_FILESYSTEM=1 \
  -s NO_EXIT_RUNTIME=0 -s ERROR_ON_UNDEFINED_SYMBOLS=0 -s ASYNCIFY

rm out/hello.js && cp custom.js out/hello.js
