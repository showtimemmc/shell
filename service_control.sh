#!/bin/bash
SERVICES=("lighttpd" "mysql" "nmqproxy" "pusher" "topic" "nginx")
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
#function stop_service()
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
	echo "usage{check|start|stop}"
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
