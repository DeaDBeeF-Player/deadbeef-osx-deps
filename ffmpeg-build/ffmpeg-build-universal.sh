#!/bin/bash
set -ex
mkdir -p build/universal/lib
rm -f build/universal/lib/*
make clean
./ffmpeg-build-arm64.sh || exit 1
make install || exit 1
make clean
./ffmpeg-build-x86_64.sh || exit 1
make install || exit 1
cd build/arm64/lib
libs=`find . -name "*.dylib" -type f`
cd ../../..
cp -R build/arm64/lib/*.dylib build/universal/lib/ # copy symlinks
for i in $libs ; do
    rm -f build/universal/lib/$i
    lipo -create -output build/universal/lib/$i build/arm64/lib/$i build/x86_64/lib/$i || exit 1
done
cp -r build/arm64/include build/universal/ || exit 1
