#!/bin/bash
set -e
cd /tools/cobol
export CC=clang
export CXX=clang++

rm -rf gnucobol-3.0-rc1
tar xvf gnucobol-3.0-rc1.tar.gz

cd gnucobol-3.0-rc1
./configure --with-db=false --disable-assembly
make install
ldconfig