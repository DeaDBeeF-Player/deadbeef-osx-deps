# This is the commands used to build the ffmpeg libs provided here
set -ex
./configure --extra-cflags="-fPIC -isysroot /Applications/Xcode_15_2_0.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk -mmacosx-version-min=10.13" --extra-ldflags="-isysroot /Applications/Xcode_15_2_0.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk -mmacosx-version-min=10.13"\
    --target-os=darwin\
    --enable-shared --disable-static\
    --prefix="$PWD/build/x86_64"\
    --enable-pic --enable-gpl --disable-doc --disable-ffplay\
    --disable-ffprobe --disable-avdevice --disable-ffmpeg\
    --disable-videotoolbox\
    --disable-demuxers --disable-decoders --disable-parsers\
    --disable-postproc --disable-swresample --disable-avfilter\
    --disable-swscale --enable-network --disable-swscale-alpha --disable-vdpau\
    --disable-dxva2 --enable-hwaccels\
    --disable-encoders --disable-muxers --disable-indevs --disable-outdevs\
    --disable-devices --disable-filters\
    --disable-bsfs --disable-bzlib --disable-protocols\
    --disable-decoder=libopus --disable-libopus\
    --enable-parser=ac3 --enable-demuxer=ac3 --enable-decoder=ac3\
    --enable-demuxer=eac3 --enable-decoder=eac3\
    --enable-decoder=wmapro --enable-decoder=wmav1 --enable-decoder=wmav2\
    --enable-decoder=wmavoice\
    --disable-decoder=amrnb\
     --enable-demuxer=asf\
    --enable-demuxer=mov --enable-demuxer=oma\
    --disable-demuxer=amr --enable-demuxer=ogg\
    --enable-demuxer=tak --enable-decoder=tak\
    --enable-decoder=dsd_lsbf --enable-decoder=dsd_lsbf_planar\
    --enable-decoder=dsd_msbf --enable-decoder=dsd_msbf_planar\
    --enable-decoder=aac\
    --enable-demuxer=dsf --enable-demuxer=iff\
    --disable-libopencore-amrnb --disable-libopencore-amrwb\
    --disable-version3 --disable-mmx\
    --disable-x86asm --disable-inline-asm --disable-asm\
    --enable-protocol=file --enable-protocol=http\
    --enable-audiotoolbox

make -j8

install_name_tool -add_rpath "@executable_path/../PlugIns" libavcodec/libavcodec.dylib 
install_name_tool -add_rpath "@executable_path/../PlugIns" libavutil/libavutil.dylib
install_name_tool -add_rpath "@executable_path/../PlugIns" libavformat/libavformat.dylib
install_name_tool -id "@rpath/libavcodec.58.dylib" libavcodec/libavcodec.dylib 
install_name_tool -id "@rpath/libavutil.56.dylib" libavutil/libavutil.dylib 
install_name_tool -id "@rpath/libavformat.58.dylib" libavformat/libavformat.dylib 
install_name_tool -change "/Users/waker/Downloads/ffmpeg-4.4/build/x86_64/lib/libavutil.56.dylib" "@rpath/libavutil.56.dylib" libavformat/libavformat.dylib
install_name_tool -change "/Users/waker/Downloads/ffmpeg-4.4/build/x86_64/lib/libavcodec.58.dylib" "@rpath/libavcodec.58.dylib" libavformat/libavformat.dylib
install_name_tool -change "/Users/waker/Downloads/ffmpeg-4.4/build/x86_64/lib/libavutil.56.dylib" "@rpath/libavutil.56.dylib" libavcodec/libavcodec.dylib
