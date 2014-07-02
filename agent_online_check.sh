#!/bin/bash
#TODO:支持多中配置文件的抓取
#orpIds=("1" "2")
orpIds=$(ls $HOME | grep "^orp00[1-9]$")

if [ $# -eq 0 ]; then 
    echo -e "\n usage {nginx|logagent|php}"
    exit 1  
fi
#检查所有部署目录下的配置文件
for orpId in ${orpIds[@]}
do
    echo  -e "\norpId:"$orpId
#XXX:组成ORP目录，目前不支持orpId大于9
#    orpdir=orp00$orpId
    orpdir=$orpId
    case $1 in
    "nginx")
        sed -n  "1,5p"  $HOME/$orpdir/webserver/conf/nginx.conf
    ;;
    "logagent")
        sed -n  "1,5p"  $HOME/$orpdir/logagent/conf/logagent.conf
    ;;
    "php")  
    sed -n "1,5p"   $HOME/$orpdir/php/etc/ext/ap.ini
    ;;
    *)
    echo -e "\n usage {nginx|logagent|php}"
   esac
done