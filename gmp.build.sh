export CC=clang
export CXX=clang++
if [[ ! -f gmp-6.1.2.tar.xz ]]
then
    wget https://gmplib.org/download/gmp/gmp-6.1.2.tar.xz
fi

rm -rf gmp.6.1.2
tar xvf gmp-6.1.2.tar.xz
#TODO Add checksum
cd gmp-6.1.2
./configure --disable-assembly --host none --enable-cxx
make clean
make
# make check
make install