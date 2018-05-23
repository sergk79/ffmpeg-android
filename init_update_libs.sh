#!/bin/bash

echo "============================================"
echo "Updating submodules"
git submodule update --init
echo "============================================"
echo "Updating libpng and lame"
rm -rf libpng-*
rm -rf lame-*

wget -O- ftp://ftp-osl.osuosl.org/pub/libpng/src/libpng16/libpng-1.6.34.tar.xz | tar xJ || exit 1
wget -O- https://sourceforge.net/projects/lame/files/lame/3.100/lame-3.100.tar.gz | tar xz || exit 1
echo "============================================"
