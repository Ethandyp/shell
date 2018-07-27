#!/bin/bash

# author:Ethan
# date:20180717
# version:1
# centos:7

# 安装docker
function install () {
	echo "开始安装docker................"
	export CHANNEL=stable
	curl -fsSL https://get.docker.com/ | sh -s -- --mirror Aliyun
	check_status "安装docker"
}

# 配置国内加速器
function config () {
	echo "开始配置加速器................."
	cp /usr/lib/systemd/system/docker.service /usr/lib/systemd/system/docker.service.bak
	sed -i "s#ExecStart=/usr/bin/dockerd#ExecStart=/usr/bin/dockerd --registry-mirror=https://registry.docker-cn.com#g" /usr/lib/systemd/system/docker.service
	check_status "配置加速器"
}

# 启动docker
function start () {
	echo "开始启动docker................"
	systemctl start docker
	proce_num=`ps -ef|grep docker|grep -v "grep"|wc -l`
	if((proce_num > 0))
		then
			echo "sucess start docker"
		else
			echo "failed start docker"
		fi
	check_status "启动docker"
}

function check_status() {
	RETVAL=$?
	if [[ $RETVAL == 0 ]]
		then
		echo "$1成功"
	else
		echo "$1失败，终止安装"
		exit 20
	fi
}


function main() {
	install
	config
	start
	echo "自动化安装脚本执行成功！"
}

main