#!/bin/bash

port=65400;#开启的端口
host='127.0.0.1';#作用域
homework=`pwd`;

function startService()
{
    cd $homework;
    `nohup php -S $host:$port -t ./workroot >/dev/null 2>&1 &`  && echo -e "\033[42;34m [OK] 成功开启服务 \033[0m";
}

function stopService()
{
    running_pid=`ps x | grep '127.0.0.1:65400' | grep -v 'grep' | awk  '{print $1}' `;
    kill $running_pid && echo -e "\033[42;34m 服务已关闭--- \033[0m";
}

function isRunning()
{
    running_pid=`ps x | grep $host:$port | grep -v 'grep' | awk  '{print $1}' `;
    if [ "$running_pid" != '' ]; then
        return 1;
    else
        return 0
    fi;
}

if [ "$1" != '' ]; then
    selected=$1;
else
    echo -e "[Githook Management] please select: (1~4)";
    select selected in 'start' 'stop' 'restart' 'exit'; do break; done;
fi;

isRunning;
bool=$?;
case $selected in
    'start') 
        if [ "$bool" == 1 ]; then
            echo -e "服务正在运行中....." && exit;
        fi;
        startService;
        ;;
    'stop')
        if [ "$bool" == 0 ]; then
            echo -e "服务未运行 (:" && exit;
        fi;
        stopService;
        ;;
    'restart')
        if [ "$bool" == 1 ]; then
            stopService;
            startService;
        else
           startService; 
        fi;
        ;;
    'exit')
        if [ "$bool" == 1 ]; then
            stopService;
        else
           echo -e "服务未运行 (:" && exit;
        fi;
        ;;
    *)  
        echo '请选择正确的数字' && exit;
        ;;
esac
