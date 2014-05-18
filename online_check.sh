#!/bin/bash
#TODO:支持多中配置文件的抓取


#默认查看范围
startLine=1
stopLine=5
# 注意if后的那个空格不能省
if [ $# == 2 ];then   
	startLine=$1
	stopLine=$2
fi
vars=`mysql -uroot orp << EOF
select orpId from runtime;
EOF`
#vars中取出containerId，并将字段名containerId去掉
orpIds=`echo $vars | awk -F '' '{print $0}' | sed 's/orpId//g'`
for orpId in $orpIds
do
	echo  -e "\norpId:"$orpId
#XXX:组成ORP目录，目前不支持orpId大于9
orpdir=orp00$orpId
sed -n  "$startLine,$stopLine p"  $HOME/$orpdir/webserver/conf/nginx.conf
sed -n  "$startLine,$stopLine p"  $HOME/$orpdir/logagent/conf/logagent.conf
done



