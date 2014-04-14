#!/bin/bash
#TODO:支持多中配置文件的抓取
#TODO:抓取行数参数输入
vars=`mysql -uroot orp << EOF
select orpId from runtime;
EOF`
#vars中取出containerId，并将字段名containerId去掉
orpIds=`echo $vars | awk -F '' '{print $0}' | sed 's/orpId//g'`
for orpId in $orpIds
do
    echo $orpId
#XXX:组成ORP目录，目前不支持orpId大于9
    orpdir=orp00$orpId
    echo $orp
    sed -n '1,5p' $HOME/$orpdir/webserver/conf/nginx.conf
done

