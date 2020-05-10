set -e
mkdir -p /tools/cobol
cd /tools/cobol

export CC=clang

if [[ ! -f gnucobol-3.0-rc1.tar.gz ]]
then
    wget http://sourceforge.net/projects/open-cobol/files/gnu-cobol/3.0/gnucobol-3.0-rc1.tar.gz
fi

rm -rf gnucobol-3.0-rc1
tar xvf gnucobol-3.0-rc1.tar.gz
#TODO Add checksum
cd gnucobol-3.0-rc1
./configure --with-db=false --disable-assembly --enable-cxx
make clean
# make check
make install
ldconfig