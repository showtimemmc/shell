#!/bin/bash
SERVICES=("lighttpd" "mysql" "nmqproxy" "pusher" "topic" "nginx" "php")
CONTROL_SCRIPTS=("lighttpd_control" "mysql_control" "nmqproxy_control" "pusher_control" "topic_control" "php_control")
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
#params: start|stop
function nmqproxy_control()
{
	cd /home/work/nmq/nmqproxy/bin
	echo $1
	sh nmqproxy_control $1
}
#params: start|stop
function pusher_control()
{
	cd /home/work/nmq/pusher/bin
	echo $1
	sh pusher_control $1
}
#params: start|stop
function topic_control()
{
	cd /home/work/nmq/topic/bin
	echo $1
	sh topic_control $1
}
#params: start|stop
function nginx_control()
{
	cd /home/work/nginx/bin/
	if [ $1 == "start" ]; then
		./nginx
	else
		./nginx -s stop
	fi
	
}
#params: start|stop
function lighttpd_control()
{
	cd /home/work/orp/webserver/bin
	sh lighttpd.sh $1
}
#params: start|stop
function php_control()
{
	cd /home/work/orp/php/sbin
	sh php-fpm $1
}
function check_all()
{
	for ser in ${SERVICES[@]}; 
	do
		check_service $ser
	done
}
#params:start|stop
function control_all()
{
	for ctrl in ${CONTROL_SCRIPTS[@]};
	do
		$ctrl $1
	done
}

function help()
{
	echo   "usage{check|start|stop|restart}\n"
}
#主程序入口
if [[ -n $1 ]]; then
	case $1 in
		"check" )
			check_all
			;;
		"start")
			control_all start
			;;
		"stop")
			control_all stop
			;;
		"restart")
			control_all stop && control_all start	
		*)
			help
			;;
	esac
fi
