#!/bin/sh

# http://forum.doom9.org/showthread.php?t=153119

cd ../ffmpeg/

git checkout n4.4

rm -f config.h
echo "Building ffmpeg release for Windows"

set -e

ARCH="x86_64"

# --enable-debug=0
# --enable-nonfree
# --prefix=./bin/linux/release/${ARCH}
# --enable-w32threads \
# --disable-autodetect \
# --target-os=mingw32 \
# --enable-pthreads \

GENERAL="
	--enable-cross-compile \
	--target-os=mingw32 \
	--cross-prefix=${ARCH}-w64-mingw32- \
	--enable-w32threads \
	--enable-gpl \
	--disable-shared \
	--enable-static"

# todo: reacitvate zlib
MODULES="\
	--disable-zlib \
	--disable-programs \
	--disable-doc \
	--disable-manpages \
	--disable-podpages \
	--disable-txtpages \
	--disable-ffplay \
	--disable-ffprobe \
	--disable-ffmpeg"

VIDEO_DECODERS=""

AUDIO_DECODERS=""

DEMUXERS=""

VIDEO_ENCODERS=""

AUDIO_ENCODERS=""

MUXERS=""

PARSERS=""

PROTOCOLS="\
	--enable-protocol=file"

./configure \
	--prefix=./../lib/win/release/${ARCH} \
	${GENERAL} \
	--extra-cflags="-D__STDC_CONSTANT_MACROS -O3" \
	--enable-zlib \
	--enable-pic \
	--disable-yasm \
	${MODULES} \
	${VIDEO_DECODERS} \
	${AUDIO_DECODERS} \
	${VIDEO_ENCODERS} \
	${AUDIO_ENCODERS} \
	${DEMUXERS} \
	${MUXERS} \
	${PARSERS} \
	${PROTOCOLS} \
	--arch=${ARCH}

make clean
make install
