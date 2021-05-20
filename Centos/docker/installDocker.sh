#!/bin/bash

# installDocker.sh

echo "#     Установка Docker в Centos 7     #"

##********************************************************************
#Установим репозитории EPEL и REMI

yum -y install epel-release
yum -y install http://rpms.remirepo.net/enterprise/remi-release-7.rpm
#Установим программное обеспечение и обновимся
yum -y install wget nano mc zip upzip htop yum-utils
yum -y update

# Установим репозиторий Docker
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

###Устанавливаем Docker####
yum -y install docker-ce

#Запускаем его и добавляем в автозагрузку
systemctl start docker
systemctl enable docker
systemctl status docker

#Для проверки, запустим образ hello-world
docker run hello-world
sleep 9
exit
##********************************************************************
