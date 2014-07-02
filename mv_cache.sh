#/bin/bash
USER=$(whoami)
CHROME_CACHE_DIR=/Users/$USER/Library/Caches/Google/Chrome/Default/Cache/
DEST_DIR=/Users/ishowtime/Desktop/new
cd $CHROME_CACHE_DIR
cache_files=$(ls -lSh | grep  'M' | grep -v 'data' | awk '{print $9}' | tr '\n' ' ')
if [[ ! -d $DEST_DIR ]]; then
	mkdir /Users/ishowtime/Desktop/new
fi
for cache in $cache_files
do
	mv $cache $DEST_DIR/${cache}.mp4
done

