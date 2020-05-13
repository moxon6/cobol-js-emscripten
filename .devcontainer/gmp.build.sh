#!/bin/bash
set -e
cd /tools/cobol
export CC=clang
export CXX=clang++

rm -rf gmp-6.1.2
tar xvf gmp-6.1.2.tar.xz

cd gmp-6.1.2
./configure
make
make install