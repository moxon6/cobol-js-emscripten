set -e

#!/bin/bash

export CC=clang
export CXX=clang++
if [[ ! -f gnucobol-3.0-rc1.tar.gz ]]
then
    wget http://sourceforge.net/projects/open-cobol/files/gnu-cobol/3.0/gnucobol-3.0-rc1.tar.gz
fi

rm -rf gnucobol-3.0-rc1
tar xvf gnucobol-3.0-rc1.tar.gz
#TODO Add checksum
cd gnucobol-3.0-rc1
sed -i '14680,14868d' configure # Delete GMP checks
sed -i '515,582d' configure.ac # Delete GMP checks

autoreconf -f -i

emconfigure ./configure --with-db=false --disable-assembly --host none --enable-cxx --prefix=${HOME}/opt --includedir=${HOME}/opt/include
make clean
make defaults.h
cd libcob
emmake make INCLUDES=-I/root/opt/include
make install