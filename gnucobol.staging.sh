#wget http://sourceforge.net/projects/open-cobol/files/gnu-cobol/3.0/gnucobol-3.0-rc1.tar.gz
tar xvf gnucobol-3.0-rc1.tar.gz
cd gnucobol-3.0-rc1
./configure && make && make check && make install && ldconfig