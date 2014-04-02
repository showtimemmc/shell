#!/bin/bash
#创建文件夹以当前日期结尾
if [[ -z $1 ]]; then
	echo "please input a directory name"
fi
DIRNAME=$1
DATE=$(date +%y%m%d)
FULLNAME=${DIRNAME}.${DATE}
mkdir $FULLNAME