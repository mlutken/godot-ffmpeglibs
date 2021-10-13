#!/bin/bash

ffmpeglibs_startup_dir=`pwd`
ffmpeglibs_scripts_dir="$( cd "$( dirname "${BASH_SOURCE[0]}")" && pwd )"
ffmpeglibs_dir="$( cd "$( dirname "${ffmpeglibs_scripts_dir}")" && pwd )"
ffmpeg_source_dir="${ffmpeglibs_dir}/FFmpeg"

ffmpeg_git="https://github.com/FFmpeg/FFmpeg.git"


GENERAL="
	--enable-pthreads \
	--disable-shared \
	--enable-static"

# todo: reacitvate zlib
# 	--disable-zlib \
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



echo "ffmpeglibs_scripts_dir  : ${ffmpeglibs_scripts_dir}"
echo "ffmpeglibs_dir          : ${ffmpeglibs_dir}"
echo "ffmpeg_source_dir       : ${ffmpeg_source_dir}"



if [ ! -d ${ffmpeg_source_dir} ];
then
	cd ${ffmpeglibs_dir}
	git clone --recurse-submodules ${ffmpeg_git}
else
	cd ${ffmpeg_source_dir}
	git pull --recurse-submodules
fi
cd ${ffmpeg_source_dir}
git clean -dfx


cd ${ffmpeglibs_startup_dir}

