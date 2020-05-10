
mkdir -p tmp
mkdir -p out

cobc -C -x -free hello.cob -o tmp/hello.c

# Concat say with tmp/hello.c
rm /tmp/hello.c
mv tmp/hello.c /tmp/hello.c
cat say.c /tmp/hello.c > tmp/hello.c

# Replace dynamic logic for direct function pointers
# cat say.c >> tmp/hello.c
sed -i -r "s/cob_resolve_cobol\ \(\"(.*)\",.*\);/\*\1;/g" tmp/hello.c

emcc --ignore-dynamic-linking -o out/hello.html tmp/hello.c \
  /root/opt/lib/*.a -I/root/opt/include \
  -I/tools/cobol/gnucobol-3.0-rc1 -s FORCE_FILESYSTEM=1 \
  -s NO_EXIT_RUNTIME=1 -s ERROR_ON_UNDEFINED_SYMBOLS=0 -s ASYNCIFY

sed -i '/To use dlopen/s/^/\/\//' out/hello.js # Comment out all dlopen callbacks
sed -i '/Calling stub instead/s/^/\/\//' out/hello.js # Comment out calling stub callbacks
