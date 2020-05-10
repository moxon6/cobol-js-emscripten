mkdir -p tmp
mkdir -p out

cobc -C -x -free helloworld.cob -o tmp/hello.c

emcc -o out/hello.html tmp/hello.c \
  /root/opt/lib/*.a -I/root/opt/include \
  -I/workspaces/cobol-wasm-hello-world/gnucobol-3.0-rc1 -s FORCE_FILESYSTEM=1 -s \
   NO_EXIT_RUNTIME=0 -s ERROR_ON_UNDEFINED_SYMBOLS=0

# Patch hello.js
sed -i '4714d;4909d' out/hello.js
