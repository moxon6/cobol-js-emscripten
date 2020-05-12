#!/bin/bash

set -e

# Add list of functions defined in extern.c
functions="emscripten_sleep set_square_pos startup"
functions=`echo $functions | sed -e "s/ / -K /g" | sed 's/^/-K /'`
echo $functions

mkdir -p out

build_version="debug"

build_dir=tmp/build
mkdir -p $build_dir

build_path=$build_dir/build.c
echo $build_path

cobc $functions -C -x -free cob/*.cob -o $build_path

echo $build_path

emcc -O1 -o out/index.js $build_path c/*.c \
  /root/opt/lib/*.a -I/root/opt/include \
  -I/tools/cobol/gnucobol-3.0-rc1 \
  -s ERROR_ON_UNDEFINED_SYMBOLS=0 -s ASYNCIFY \
  -s EXTRA_EXPORTED_RUNTIME_METHODS=['UTF8ToString']

# Comment out all dlopen callbacks
sed -i '/To use dlopen/s/^/\/\//' out/index.js 

# Comment out calling stub callbacks
sed -i '/Calling stub instead/s/^/\/\//' out/index.js
echo "Build Complete"