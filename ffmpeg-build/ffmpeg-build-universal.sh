#!/bin/bash
mkdir -p build/universal/lib
make clean
./ffmpeg-build-arm64.sh || exit 1
make install || exit 1
make clean
./ffmpeg-build-x86_64.sh || exit 1
make install || exit 1
cd build/arm64/lib
libs=`find *.dylib -type f`
cd ../../..
for i in $libs ; do
    lipo -create -output build/universal/lib/$i build/arm64/lib/$i build/x86_64/lib/$i || exit 1
    name=${i%%.*}
    cd build/universal/lib
    ln -s $i $name.dylib || exit 1
    cd ../../..
done
cp -r build/arm64/include build/universal/ || exit 1
