#!/bin/bash

## UpdateCentos_7to8.sh
##       wget https://raw.githubusercontent.com/numbnet/OSys/master/Centos/Scripts/UpdateCentos_7to8.sh && chmod +x ~/UpdateCentos_7to8.sh && ~/UpdateCentos_7to8.sh

wait() { 
echo "Нажмите любую клавишу, чтобы продолжить..."
read -s -n 1
}


#################################
echo "## Подготовка"

echo "# Добавляем репозиторий EPEL"
wait
yum -y install epel-release

echo "# Устанавливаем утилиту yum-utils и rpmconf"
wait
yum -y install yum-utils
yum -y install rpmconf

echo "# Выполняем проверку и сравнение конфигов"
rpmconf -a
wait

# После выполнения команды смотрим вывод утилиты и отвечаем на вопросы о том,
# какой конфиг нам нужен (текущий, дефолтный из пакета …)

echo "# определим уст. пакеты не из репо"
package-cleanup --leaves
package-cleanup --orphans
wait

#################################
echo "## Start update centos8"
echo "Установим менеджер пакетов dnf"
yum -y install dnf

echo "# НЕ Удалим менеджер пакетов yum"
#wait
#dnf -y remove yum yum-metadata-parser
#rm -Rf /etc/yum

echo "# Обновляем Centos"
wait
dnf -y upgrade

echo "# Устан. пакеты для CentOS 8"
wait
dnf -y install \
http://vault.centos.org/8.2.2004/BaseOS/x86_64/os/Packages/centos-repos-8.2-2.2004.0.1.el8.x86_64.rpm \
http://vault.centos.org/8.2.2004/BaseOS/x86_64/os/Packages/centos-release-8.2-2.2004.0.1.el8.x86_64.rpm \
http://vault.centos.org/8.2.2004/BaseOS/x86_64/os/Packages/centos-gpg-keys-8.2-2.2004.0.1.el8.noarch.rpm


echo "# Обновляем репозиторий EPEL"
wait
dnf -y upgrade https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm

# Удаляем временные файлы
dnf clean all

echo "# Удаляем старые ядра от Centos 7"
wait
rpm -e `rpm -q kernel`

echo "# Удаляем пакеты, которые могут конфликтовать"
wait
rpm -e --nodeps sysvinit-tools
dnf -y remove python36-rpmconf
#dnf remove -y iptables
#dnf remove -y ebtables

echo "# Запускаем обновление системы"
wait
dnf -y --releasever=8 --allowerasing --setopt=deltarpm=false distro-sync


#################################
echo "## Ядро для Centos 8"
echo "# Устанавливаем новое ядро для CentOS 8"
wait
dnf -y install kernel-core --allowerasing
# dnf -y install kernel-core

echo "#Устанавливаем минимальный набор пакетов через групповое управление"
wait
dnf -y groupupdate "Core" "Minimal Install" --allowerasing

echo "#Проверяем, какая версия centos установилась"
cat /etc/*release
wait

echo "#Удаляем временные файлы"
wait
dnf clean all
dnf -y install yum

echo "The End";

wait
exit
