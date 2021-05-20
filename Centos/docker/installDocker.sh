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
yum -y install dnf wget nano mc zip upzip htop yum-utils device-mapper-persistent-data lvm2
dnf install 'dnf-command(config-manager)'

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
docker -v
wait


##********************************************************************
# Установка Docker Compose
curl -L "https://github.com/docker/compose/releases/download/1.26.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
docker-compose -v
##********************************************************************

echo " Уст. закончена Выходими. "
exit
