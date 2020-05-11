#!/bin/bash

set -e

functions=`cproto -I/emsdk_portable/upstream/emscripten/system/include /workspaces/cobol-js-emscripten/c/jsrun.c | tail -n +2 | cut -d' ' -f2 | cut -d '(' -f1`


functions=`echo $functions | sed -e "s/ / -K /g"  | sed 's/^/-K /'`
echo $functions

# Create output directory
mkdir -p out
rm -rf out/*

#build_number=$(date -d "today" +"%Y%m%d%H%M%s")
build_number="testbuild"
rm -rf /tmp/cobol-js-builds/$build_number



echo "COBOL -> JS - Build version: $build_number"
mkdir -p /tmp/cobol-js-builds/$build_number

out1=/tmp/cobol-js-builds/$build_number/out.1.c

cobc $functions -C -x -free cob/*.cob -o $out1
cat c/*.c /tmp/cobol-js-builds/$build_number/out.1.c > /tmp/cobol-js-builds/$build_number/out.2.c

# Replace dynamic logic for direct function pointers
# sed -r "s/cob_resolve_cobol\ \(\"(.*)\",.*\);/\*\1;/g" /tmp/cobol-js-builds/$build_number/out.2.c >> /tmp/cobol-js-builds/$build_number/out.3.c

# sed "s/cob_stop_run .[^M].*//g" /tmp/cobol-js-builds/$build_number/out.3.c >> /tmp/cobol-js-builds/$build_number/out.3.c

echo /tmp/cobol-js-builds/$build_number/out.2.c

emcc --ignore-dynamic-linking -o out/index.html /tmp/cobol-js-builds/$build_number/out.2.c \
  /root/opt/lib/*.a -I/root/opt/include \
  -I/tools/cobol/gnucobol-3.0-rc1 -s FORCE_FILESYSTEM=1 \
  -s NO_EXIT_RUNTIME=1 -s ERROR_ON_UNDEFINED_SYMBOLS=0 -s ASYNCIFY -s 

# Comment out all dlopen callbacks
sed -i '/To use dlopen/s/^/\/\//' out/index.js 

# Comment out calling stub callbacks
sed -i '/Calling stub instead/s/^/\/\//' out/index.js
