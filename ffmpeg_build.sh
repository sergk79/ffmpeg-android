#!/bin/bash

. abi_settings.sh $1 $2 $3

oot="${2}/build/static/${1}/oot/ffmpeg/"
mkdir -p "$oot"
pushd "$oot"

case $1 in
  armeabi-v7a | armeabi-v7a-neon)
    CPU='cortex-a8'
  ;;
  arm64-v8a | arm64-v8a-neon)
    CPU='armv8-a'
  ;;
  x86)
    CPU='i686'
  ;;
esac

make distclean

"${2}/ffmpeg/configure" \
--target-os="$TARGET_OS" \
--cross-prefix="$CROSS_PREFIX" \
--arch="$NDK_ABI" \
--cpu="$CPU" \
--enable-runtime-cpudetect \
--sysroot="$NDK_SYSROOT" \
--enable-pic \
--enable-libx264 \
--disable-libass \
--disable-libfreetype \
--disable-libfribidi \
--enable-libmp3lame \
--disable-fontconfig \
--enable-pthreads \
--enable-debug \
--enable-version3 \
--enable-hardcoded-tables \
--enable-ffmpeg \
--disable-ffprobe \
--disable-network \
--disable-htmlpages \
--disable-manpages \
--disable-podpages \
--disable-txtpages \
--enable-gpl \
--disable-avdevice \
--enable-asm \
--disable-doc \
--disable-shared \
--enable-static \
--pkg-config="${2}/ffmpeg-pkg-config" \
--prefix="${2}/build/static/${1}" \
--extra-cflags="-I${TOOLCHAIN_PREFIX}/include $CFLAGS" \
--extra-ldflags="-L${TOOLCHAIN_PREFIX}/lib $LDFLAGS" \
--extra-libs="-lpng -lz -lm -lmp3lame -lx264" \
--extra-cxxflags="$CXX_FLAGS" || exit 1

make -j${NUMBER_OF_CORES} && make install || exit 1

popd
