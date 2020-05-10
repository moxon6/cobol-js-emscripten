# Build and install GMP first
./gmp.build.sh
./gnucobol.build.sh

# Build and install Wasm versions
./gmp.build-wasm.sh
./gnucobol.build-wasm.sh # Note (Only libcob is included)