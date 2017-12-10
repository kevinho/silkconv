#!/bin/bash

# Colors
RED="$(tput setaf 1 2>/dev/null || echo '\e[0;31m')"
GREEN="$(tput setaf 2 2>/dev/null || echo '\e[0;32m')"
YELLOW="$(tput setaf 3 2>/dev/null || echo '\e[0;33m')"
WHITE="$(tput setaf 7 2>/dev/null || echo '\e[0;37m')"
RESET="$(tput sgr 0 2>/dev/null || echo '\e[0m')"

cur_dir=$(cd `dirname $0`; pwd)

silkdec "$1" "$1.pcm" > /dev/null 2>&1

if [ ! -f "$1.pcm" ]; then
	ffmpeg -y -i "$1" "${1%.*}.$2" > /dev/null 2>&1 &
	ffmpeg_pid=$!
	while kill -0 "$ffmpeg_pid"; do sleep 1; done > /dev/null 2>&1
	[ -f "${1%.*}.$2" ]&&echo -e "${GREEN}[OK]${RESET} Convert $1 to ${1%.*}.$2 success, ${YELLOW}but not a silk v3 encoded file.${RESET}"&&exit
	echo -e "${YELLOW}[Warning]${RESET} Convert $1 false, maybe not a silk v3 encoded file."&&exit
fi

if [ "$2" == "amr" ]
then
    ffmpeg -y -f s16le -ar 24k -ac 1 -i "$1.pcm" -ar 8k -b:a 12.2k "${1%.*}.$2" > /dev/null 2>&1
else
    ffmpeg -y -f s16le -ar 24k -ac 1 -i "$1.pcm" "${1%.*}.$2" > /dev/null 2>&1
fi
ffmpeg_pid=$!
while kill -0 "$ffmpeg_pid"; do sleep 1; done > /dev/null 2>&1
rm "$1.pcm"
[ ! -f "${1%.*}.$2" ]&&echo -e "${YELLOW}[Warning]${RESET} Convert $1 false, maybe ffmpeg no format handler for $2."&&exit
echo -e "${GREEN}[OK]${RESET} Convert $1 To ${1%.*}.$2 Finish."
exit