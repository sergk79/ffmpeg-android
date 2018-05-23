#!/bin/bash

. abi_settings.sh $1 $2 $3

pushd lame-3.100

make clean

case $1 in
  armeabi-v7a | armeabi-v7a-neon)
    HOST=arm-linux-android
  ;;
  arm64-v8a | arm64-v8a-neon)
    HOST=aarch64-linux-android
  ;;
  x86 | x86_64)
    HOST=i686-linux-android
  ;;
esac

./configure \
  --with-pic \
  --with-sysroot="$NDK_SYSROOT" \
  --host="$HOST" \
  --enable-static \
  --prefix="${TOOLCHAIN_PREFIX}" \
  --enable-arm-neon="$ARM_NEON" \
  --disable-shared || exit 1

make -j${NUMBER_OF_CORES} install || exit 1

popd
