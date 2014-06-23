#检查服务是否运行在cgroups的进程组中
#1.ps出所有服务的pid
#2.和cgroup中的进程文件diff
#3.根据diff结果，判断服务进程是否运行在进程组中
#! /bin/bash
MATRIX_DIR=/home/matrix/containers
HOME_WORK=home/work
containers=$(ls $MATRIX_DIR)
err_code=0
for container in $containers
do
echo "+++++++++++++++++$container+++++++++++++++++++"
	container_path=$MATRIX_DIR/$container/$HOME_WORK
   # echo $container_path
	orpid=$(ls $container_path| grep "orp...")
    if [ $? -ne 0 ];then
        echo "please execute mi.sh first"
        exit -1
    fi
   # echo  $orpid
   
    ps -ef | grep $orpid | egrep -v "grep" | awk '{printf $2"\n"}' > ${orpid}_pids.tmp
	diff -c ./${orpid}_pids.tmp  /cgroups/cpu/$container/tasks > ${orpid}_diff.tmp   
   
   #正则表达式:去掉diff结果中不是pid的行
   #搜索pid行的头一个字段，除+和数字外还有其他字符(-!)，则证明有pid未运行在container中
   result=$(sed  '/[*-]\{3,\}/d'  ${orpid}_diff.tmp  | awk '{print $1}' | grep -v "+" | grep -v "[0-9]" | tr -d '\n')
   echo $result
   #result中没有+或者pid，表示pid都运行在container中
   if [ -z  $result ];then
       echo "pids is running in $container"
   else
       echo "pids is not running in $container,please check" 
       echo "search result: $result"
       let err_code=1
   fi
   
   
   # rm ${orpid}_pids.tmp ${orpid}_diff_result
done

exit $err_code


