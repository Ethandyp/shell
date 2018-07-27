#!/bin/bash

#author:Ethan
#date:20180312
#version:1
#centos:7

#设置启动级别
RUNLEVEL="multi-user"
CRUNLEVEL=`systemctl get-default`
echo "current run level: $CRUNLEVEL"
if [[ ! $CRUNLEVEL =~ $RUNLEVEL ]]
then
    echo "changing to level: $RUNLEVEL"
    systemctl set-default $RUNLEVEL
    systemctl isolate $RUNLEVEL

#更新yum源
yum -y install wget
rm -rf /etc/yum.repos.d/*.repo
#mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup
wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
yum makecache

