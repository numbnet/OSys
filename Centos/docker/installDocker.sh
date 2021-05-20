#!/bin/bash

# installDocker.sh
wait()
{
  echo ""
  echo "Нажмите любую клавишу, чтобы продолжить..."
  read -s -n 1
}

##********************************************************************
echo "# --------- Установка Docker в Centos 7 --------- #"
wait

# Установим репозитории EPEL и REMI
yum -y install epel-release
yum -y install http://rpms.remirepo.net/enterprise/remi-release-7.rpm
# программное обеспечение и обновимся
yum -y install wget nano mc zip upzip htop yum-utils
yum -y update

# репозиторий Docker
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

# Уст. Docker####
yum -y install docker-ce

# Запуск и доб. в автозагрузку
systemctl start docker
systemctl enable docker
systemctl status docker

# Для проверки, запустим образ hello-world
docker run hello-world

echo " Уст. закончена Выходими. "
wait
exit
##********************************************************************
