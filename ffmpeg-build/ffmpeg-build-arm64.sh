#!/bin/bash
# This is the commands used to build the ffmpeg libs provided here
set -ex
XCODE=$(xcode-select -p)
FFMPEG=$(pwd)
./configure \
  --cc="clang -arch arm64" \
  --cxx="clang++ -arch arm64" \
  --extra-cflags="-fPIC -isysroot ${XCODE}/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk -mmacosx-version-min=11.0 -arch arm64" --extra-ldflags="-isysroot ${XCODE}/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk -mmacosx-version-min=11.0 -arch arm64"\
    --arch=arm64\
    --enable-cross-compile\
    --target-os=darwin\
    --enable-shared --disable-static\
    --prefix="$PWD/build/arm64"\
    --enable-pic --enable-gpl --disable-doc --disable-ffplay\
    --disable-ffprobe --disable-avdevice --disable-ffmpeg\
    --disable-videotoolbox\
    --disable-demuxers --disable-decoders --disable-parsers\
    --disable-swresample --disable-avfilter\
    --disable-swscale --enable-network --disable-swscale-alpha --disable-vdpau\
    --disable-dxva2 --enable-hwaccels\
    --disable-encoders --disable-muxers --disable-indevs --disable-outdevs\
    --disable-devices --disable-filters\
    --disable-xlib\
    --disable-libxcb\
    --disable-libxcb-shm\
    --disable-libxcb-xfixes\
    --disable-libxcb-shape\
    --disable-bsfs --disable-bzlib --disable-protocols\
    --disable-decoder=libopus --disable-libopus\
    --enable-parser=ac3 --enable-demuxer=ac3 --enable-decoder=ac3\
    --enable-demuxer=eac3 --enable-decoder=eac3\
    --enable-decoder=wmapro --enable-decoder=wmav1 --enable-decoder=wmav2\
    --enable-decoder=wmavoice\
    --enable-decoder=flac\
    --disable-decoder=amrnb\
     --enable-demuxer=asf\
    --enable-demuxer=mov --enable-demuxer=oma\
    --disable-demuxer=amr --enable-demuxer=ogg\
    --enable-demuxer=tak --enable-decoder=tak\
    --enable-demuxer=hls --enable-demuxer=mpegts --enable-demuxer=flac\
    --enable-decoder=dsd_lsbf --enable-decoder=dsd_lsbf_planar\
    --enable-decoder=dsd_msbf --enable-decoder=dsd_msbf_planar\
    --enable-decoder=aac\
    --enable-demuxer=dsf --enable-demuxer=iff\
    --disable-libopencore-amrnb --disable-libopencore-amrwb\
    --disable-version3 --disable-mmx\
    --disable-x86asm --disable-inline-asm --disable-asm\
    --enable-protocol=file\
    --enable-protocol=http --enable-protocol=https\
    --enable-audiotoolbox

make -j8

install_name_tool -add_rpath "@executable_path/../PlugIns" libavcodec/libavcodec.dylib 
install_name_tool -add_rpath "@executable_path/../PlugIns" libavutil/libavutil.dylib
install_name_tool -add_rpath "@executable_path/../PlugIns" libavformat/libavformat.dylib
install_name_tool -id "@rpath/libavcodec.62.dylib" libavcodec/libavcodec.dylib 
install_name_tool -id "@rpath/libavutil.60.dylib" libavutil/libavutil.dylib 
install_name_tool -id "@rpath/libavformat.62.dylib" libavformat/libavformat.dylib 
install_name_tool -change "${FFMPEG}/build/arm64/lib/libavutil.60.dylib" "@rpath/libavutil.60.dylib" libavformat/libavformat.dylib
install_name_tool -change "${FFMPEG}/build/arm64/lib/libavcodec.62.dylib" "@rpath/libavcodec.62.dylib" libavformat/libavformat.dylib
install_name_tool -change "${FFMPEG}/build/arm64/lib/libavutil.62.dylib" "@rpath/libavutil.62.dylib" libavcodec/libavcodec.dylib
