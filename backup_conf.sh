#!/bin/bash
#创建文件夹以当前日期结尾
if [ -z $1 ]; then
	echo "please input a directory name"
    exit 1
fi
DIRNAME=$1
DATE=$(date +%y%m%d)
FULLNAME=${DIRNAME}.${DATE}
mkdir /home/work/$FULLNAME
cp -r /home/work/orp/conf /home/work/$FULLNAME
