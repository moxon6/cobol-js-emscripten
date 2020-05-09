wget https://gmplib.org/download/gmp/gmp-6.1.2.tar.xz
tar xvf gmp-6.1.2.tar.xz
#TODO Add checksum
cd gmp-6.1.2
./configure
make clean
make
make check
make install