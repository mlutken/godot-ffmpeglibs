#!/bin/bash
ARCH="x86_64"

ffmpeglibs_startup_dir=`pwd`
ffmpeglibs_scripts_dir="$( cd "$( dirname "${BASH_SOURCE[0]}")" && pwd )"
echo "ffmpeglibs_scripts_dir::: ${ffmpeglibs_scripts_dir}"

. ${ffmpeglibs_scripts_dir}/ffmpeg_source.sh

prefix_dir=${ffmpeglibs_dir}/lib/linux/release/${ARCH}
echo "Building ffmpeg in release for Linux"
rm -rf ${prefix_dir}

set -e


cd ${ffmpeg_source_dir}

./configure \
	--prefix=${prefix_dir} \
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

make -j clean
make -j install

cd ${ffmpeglibs_startup_dir}
