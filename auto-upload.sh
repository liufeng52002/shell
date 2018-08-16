#!/bin/bash

UPDATE_PATH=~/shell

ping -c 1 114.114.114.114 > /dev/null 2>&1

if [ $? -eq 0 ];then
    echo "网络链接正常，开始自动同步$UPDATE_PATH"
    cd UPDATE_PATH
    echo 'cd success'
    if [ ! -f update.log  ];then
        touch update.log
    fi
    echo -e "last commit info:" >> update.log
    echo `git log -2` >> update.log
    git add *
    git commit -m "auto-update"
    echo -e "\nauto update:" >> update.log
    echo `git log -1` >> update.log
    git add *
    git commit -m "auto-update"
    git push -f -u origin master
else
    echo "网络链接异常，未能同步$UPDATE_PATH"
    echo -e "\nInternet connection failed:  `date`\n" >> update.log
fi
