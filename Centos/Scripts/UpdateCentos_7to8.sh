#!/bin/bash

## UpdateCentos_7to8.sh
##wget https://raw.githubusercontent.com/numbnet/OSys/master/Centos/Scripts/UpdateCentos_7to8.sh

##  Update Centos7 to Centos8  ##
yum -y update $$ yum -y upgrade
#################################
## Подготовка

# Добавляем репозиторий EPEL
yum -y install epel-release

# Устанавливаем утилиту yum-utils
yum -y install yum-utils

# Устанавливаем утилиту rpmconf
yum -y install rpmconf

# Выполняем проверку и сравнение конфигов
rpmconf -a

# После выполнения команды смотрим вывод утилиты и отвечаем на вопросы о том, 
#какой конфиг нам нужен (текущий, дефолтный из пакета …)

# Смотрим, какие у нас установлены пакеты не из репозиториев, есть ли в системе пакеты, которые можно удалить
package-cleanup --leaves
package-cleanup --orphans

#################################
## Обновление Centos до версии 8

# Установим менеджер пакетов dnf, который используется по умолчанию в CentOS 8
yum -y install dnf

# Удалим менеджер пакетов yum (если он в дальнейшем вам не нужен)
dnf -y remove yum yum-metadata-parser
rm -Rf /etc/yum

# Обновляем Centos
dnf -y upgrade

# Устанавливаем необходимые пакеты для CentOS 8
dnf -y install \
  http://vault.centos.org/8.2.2004/BaseOS/x86_64/os/Packages/centos-repos-8.2-2.2004.0.1.el8.x86_64.rpm \
  http://vault.centos.org/8.2.2004/BaseOS/x86_64/os/Packages/centos-release-8.2-2.2004.0.1.el8.x86_64.rpm \
  http://vault.centos.org/8.2.2004/BaseOS/x86_64/os/Packages/centos-gpg-keys-8.2-2.2004.0.1.el8.noarch.rpm

# Обновляем репозиторий EPEL
dnf -y upgrade https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm

# Удаляем временные файлы
dnf clean all

# Удаляем старые ядра от Centos 7
rpm -e `rpm -q kernel`

# Удаляем пакеты, которые могут конфликтовать
rpm -e --nodeps sysvinit-tools
dnf -y remove python36-rpmconf


# Запускаем обновление системы
dnf -y --releasever=8 --allowerasing --setopt=deltarpm=false distro-sync


#################################
## Ядро для Centos 8
#Устанавливаем новое ядро для CentOS 8
dnf -y install kernel-core

#Устанавливаем минимальный набор пакетов через групповое управление
dnf -y groupupdate "Core" "Minimal Install"

#Проверяем, какая версия centos установилась
cat /etc/*release

#Удаляем временные файлы
dnf clean all
dnf -y install yum

exit

