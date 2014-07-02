#!/bin/bash
USER=$(whoami)
CHROME_CACHE_DIR=/Users/$USER/Library/Caches/Google/Chrome/Default/Cache/
DEFAULT_DIR=/Users/$USER/Desktop/test
#DEST_DIR=$DEFAULT_DIR

if [[ $1 == 'help' || $1 == '-h' ]]; then
	echo "输入缓存提取后存储的绝对路径"
	exit 0
fi

[ $# -ne 0 ] && DEST_DIR=$1 || DEST_DIR=$DEFAULT_DIR

cd $CHROME_CACHE_DIR
cache_files=$(ls -lSh | grep  'M' | grep -v 'data' | awk '{print $9}' | tr '\n' ' ')
#if [[ ! -d $DEFAULT_DIR ]]; then
#	mkdir /Users/$USER/Desktop/new
#fi
echo $DEST_DIR
[[ ! -d $DEST_DIR ]] && mkdir $DEST_DIR

for cache in $cache_files
do
	mv $cache $DEST_DIR/${cache}.mp4
done
