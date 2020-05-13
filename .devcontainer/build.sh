set -e 

cd "$(dirname "$0")"

# Fetch dependencies
./fetch-dependencies.sh

# Build and install GnuCobol and dependencies first
./gmp.build.sh
./gnucobol.build.sh

# Build wasm versions of these dependencies
./gmp.build-wasm.sh
./gnucobol.build-wasm.sh # Note (Only libcob is included)