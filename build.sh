set -e

# Create output directory
mkdir -p out
rm -rf out/*

build_number=$(date -d "today" +"%Y%m%d%H%M%s")
echo "Build version: $build_number"
mkdir -p /tmp/cobol-js-builds/$build_number

cobc -C -x -free cob/*.cob -o /tmp/cobol-js-builds/$build_number/out.1.c
cat c/*.c /tmp/cobol-js-builds/$build_number/out.1.c > /tmp/cobol-js-builds/$build_number/out.2.c

# Replace dynamic logic for direct function pointers
sed -r "s/cob_resolve_cobol\ \(\"(.*)\",.*\);/\*\1;/g" /tmp/cobol-js-builds/$build_number/out.2.c >> /tmp/cobol-js-builds/$build_number/out.3.c

emcc --ignore-dynamic-linking -o out/index.html /tmp/cobol-js-builds/$build_number/out.3.c \
  /root/opt/lib/*.a -I/root/opt/include \
  -I/tools/cobol/gnucobol-3.0-rc1 -s FORCE_FILESYSTEM=1 \
  -s NO_EXIT_RUNTIME=1 -s ERROR_ON_UNDEFINED_SYMBOLS=0 -s ASYNCIFY

# Comment out all dlopen callbacks
sed -i '/To use dlopen/s/^/\/\//' out/index.js 

# Comment out calling stub callbacks
sed -i '/Calling stub instead/s/^/\/\//' out/index.js
