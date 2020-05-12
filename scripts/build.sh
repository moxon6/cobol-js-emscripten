#!/bin/bash

set -e

functions=$(cproto -I/emsdk_portable/upstream/emscripten/system/include /workspaces/cobol-js-emscripten/c/*.c  \
  | grep -v "/\*"  \
  | sed '/const /d' \
  | cut -d' ' -f2  \
  | cut -d '(' -f1)


functions=`echo $functions | sed -e "s/ / -K /g"  | sed 's/^/-K /'`
echo $functions

# Create output directory
mkdir -p out

rm -rf out/*.wasm

mkdir -p tmp

# build_num=`find tmp/* -maxdepth 0 -type d | wc -l`
build_num="2"

echo "COBOL -> JS - Build version: $build_num"

build_dir=tmp/build-$build_num
mkdir -p $build_dir

build_path=$build_dir/build.c
echo $build_path

cobc -K set_square_pos $functions -C -x -free cob/*.cob -o $build_path

echo $build_path

emcc -O0 --ignore-dynamic-linking -o out/index.js $build_path c/*.c \
  /root/opt/lib/*.a -I/root/opt/include \
  -I/tools/cobol/gnucobol-3.0-rc1 -s FORCE_FILESYSTEM=1 \
  -s NO_EXIT_RUNTIME=1 -s ERROR_ON_UNDEFINED_SYMBOLS=0 -s ASYNCIFY -s \
  -s EXTRA_EXPORTED_RUNTIME_METHODS=['UTF8ToString']


# Comment out calling stub callbacks
sed -i '/Calling stub instead/s/^/\/\//' out/index.js
echo "Build Complete"