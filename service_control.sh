#!/bin/bash
SERVICES=("lighttpd" "mysql" "nmqproxy" "pusher" "topic" "nginx")
#检查某一个服务是否启动
function check_service()
{
	local len=$(ps -ef | grep $1 | egrep -v "grep|statusdetect.sh" | wc -l)
	if [ $len == 0 ]; then
		echo "$1 doesn't start"
	else
		echo "$1 started"
	fi
}
function nmqproxy_control()
{
	cd /home/work/nmq/nmqproxy/bin
	echo $1
	sh nmqproxy_control.sh $1
}
function pusher_control()
{
	cd /home/work/nmq/pusher/bin
	echo $1
	sh pusher_control.sh $1
}
function topic_control()
{
	cd /home/work/nmq/topic/bin
	echo $1
	sh topic_control.sh $1
}
function nginx_control()
{
	cd /home/work/nginx/bin/
	if [ $1 == "start" ]; then
		./nginx
	else
		./nginx -s stop
	fi
	
}
function lighttpd_control()
{
	cd /home/work/orp/webserver/bin
	sh lighttpd.sh $1
}
function check_all()
{
	for ser in ${SERVICES[@]}; 
	do
		check_service $ser
	done
}
#function start_all()
#function stop_all()
function help()
{
	echo  "usage{check|start|stop}\n
			start:"
}
#主程序入口
if [ -n $1 ]; then
	case $1 in
		"check" )
			check_all
			;;
		"lighttpd")
			check_service lighttpd
			;;
		"start")
			nmqproxy_control   starting
			;;	
		*)
			help
			;;
	esac
fi
