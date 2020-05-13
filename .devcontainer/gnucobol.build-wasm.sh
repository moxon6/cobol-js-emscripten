#!/bin/bash
set -e
cd /tools/cobol
export CC=clang
export CXX=clang++

rm -rf gnucobol-3.0-rc1
tar xvf gnucobol-3.0-rc1.tar.gz

cd gnucobol-3.0-rc1
sed -i '14680,14868d' configure # Delete GMP checks
sed -i '515,582d' configure.ac # Delete GMP checks

autoreconf -f -i

emconfigure ./configure --with-db=false --disable-assembly --prefix=${HOME}/opt --includedir=${HOME}/opt/include
make defaults.h
cd libcob
emmake make INCLUDES=-I/root/opt/include
make install