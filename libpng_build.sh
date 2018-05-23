#!/bin/bash

. abi_settings.sh $1 $2 $3

pushd libpng-1.6.34

make clean

ARM_NEON="no"
case $1 in
  armeabi-v7a-neon | arm64-v8a-neon)
    ARM_NEON="yes"
    ;;
esac

./configure \
  --with-pic \
  --with-sysroot="$NDK_SYSROOT" \
  --host="$NDK_TOOLCHAIN_ABI" \
  --enable-static \
  --prefix="${TOOLCHAIN_PREFIX}" \
  --enable-arm-neon="$ARM_NEON" \
  --enable-shared || exit 1

make -j${NUMBER_OF_CORES} install || exit 1

popd
