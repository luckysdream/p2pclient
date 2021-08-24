#!/bin/bash


#检查docker程序是否存在不存在就安装
if [ ! -d "/usr/bin/docker" ]; then
    read -p "Press enter to install docker" bcaucbau 
    yum -y install docker
    systemctl start docker
    systemctl enable docker
fi

#判断防火墙
firewalld_a=$(systemctl status firewalld | grep "Active:" | awk '{print $2}')
iptables_a=$(systemctl status firewalld | grep "Active:" | awk '{print $2}')
if [ $firewalld_a = active ]; then
    echo "firewalld stoping"
    systemctl stop firewalld &>/dev/null
    echo "firewalld stop!"
fi
if [ $iptables_a = active ]; then
    echo "iptables stoping"
    systemctl stop iptables &>/dev/null
    echo "iptables stop!"
fi

clear

#定义数据
read -p "Your Mail:" mail_add 
read -p "Docker Num:" num 

clear

#数据展示
echo "The email you entered:"$mail_add
echo "Docker Num:":$num
clear

#循环启动docker
for ((i=1;i<=$num;i++))
do
	docker run -d --restart=on-failure notfourflow/p2pclient $mail_add
done