<h1>Обновление CentOS 7 до CentOS 8</h1>
<div><img src="https://itdraft.ru/wp-content/uploads/2018/12/1051518_28b0_3.jpg" width="100%" height="auto">
<div><p class="has-text-align-center has-large-font-size">Centos 7 upgrade to Centos 8</p></div></div>
<div>
<blockquote class="wp-block-quote"><p>## CentOS — дистрибутив Linux, основанный на коммерческом Red Hat Enterprise Linux компании Red Hat и совместимый с ним. Согласно жизненному циклу Red Hat Enterprise Linux (RHEL), CentOS 5, 6 и 7 будут поддерживаться «до 10 лет», поскольку они основаны на RHEL. Ранее версия CentOS 4 поддерживалась семь лет.</p></blockquote>
<hr>
<h2>Содержание</h3>
<ol class="table-of-contents__list js-table-of-contents-list" style="display: none;">
<li class="level-1"><a href="#podgotovka">## Подготовка</a></li>
<li class="level-1"><a href="#obnovlenie-centos-do-versii-8">## Обновление Centos до версии 8</a></li>
<li class="level-1"><a href="#yadro-dlya-centos-8">## Ядро для Centos 8</a></li>
<li class="level-1"><a href="#oshibka-pri-ustanovke-yum">## Ошибка при установке YUM</a></li>
</ol></div>

<h3>## Подготовка</h3>
<p>## Добавляем репозиторий EPEL</p>
<pre><code>
$ sudo yum -y install epel-release
</code></pre>
<p>## Устанавливаем утилиту yum-utils</p>
<pre><code>
$ sudo yum -y install yum-utils
</code></pre>
<p>## Устанавливаем утилиту rpmconf</p>
<pre><code>
$ sudo yum -y install rpmconf
</code></pre>
<p>## Выполняем проверку и сравнение конфигов</p>
<pre><code>
$ sudo rpmconf -a
</code></pre>
<p>## После выполнения команды смотрим вывод утилиты и отвечаем на вопросы о том, какой конфиг нам нужен (текущий, дефолтный из пакета …)</p>
<p>## Смотрим, какие у нас установлены пакеты не из репозиториев, есть ли в системе пакеты, которые можно удалить</p>
<pre><code>
$ sudo package-cleanup --leaves
$ package-cleanup --orphans
</code></pre>

<h3>## Обновление Centos до версии 8</h3>
<p>## Установим менеджер пакетов dnf, который используется по умолчанию в CentOS 8</p>
<pre><code>
$ sudo yum -y install dnf
</code></pre>
<p>## Удалим менеджер пакетов yum (если он в дальнейшем вам не нужен)</p>
<pre><code>
$ sudo dnf -y remove yum yum-metadata-parser
$ sudo rm -Rf /etc/yum
</code></pre>
<p>## Обновляем Centos</p>
<div class="code-block code-block-3" style="margin: 8px 0; clear: both;">
<ins class="adsbygoogle" style="display:block" data-ad-client="ca-pub-1734532251661952" data-ad-slot="5888663144" data-ad-format="auto" data-full-width-responsive="true"></ins></div>
<pre><code>
$ sudo dnf -y upgrade
</code></pre>
<p>## Устанавливаем необходимые пакеты для CentOS 8</p>
<pre><code>
$ sudo dnf -y install \
	$ http://mirror.centos.org/centos/8/BaseOS/x86_64/os/Packages/centos-linux-repos-8-2.el8.noarch.rpm \
	$ http://mirror.centos.org/centos/8/BaseOS/x86_64/os/Packages/centos-linux-release-8.3-1.2011.el8.noarch.rpm \
	$ http://mirror.centos.org/centos/8/BaseOS/x86_64/os/Packages/centos-gpg-keys-8-2.el8.noarch.rpm \
</code></pre>
<pre><code>
## * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * ##
### No Work Link
#$ sudo dnf -y install \
	#$ http://mirror.centos.org/centos/8/BaseOS/x86_64/os/Packages/centos-repos-8.2-2.2004.0.1.el8.x86_64.rpm \
	#$ http://mirror.centos.org/centos/8/BaseOS/x86_64/os/Packages/centos-release-8.2-2.2004.0.1.el8.x86_64.rpm \
	#$ http://mirror.centos.org/centos/8/BaseOS/x86_64/os/Packages/centos-gpg-keys-8.2-2.2004.0.1.el8.noarch.rpm
## * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * ##
</code></pre>
<p>## Обновляем репозиторий EPEL</p>
<pre><code>
$ sudo dnf -y upgrade https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
</code></pre>
<p>## Удаляем временные файлы</p>
<pre><code>
$ sudo dnf clean all
</code></pre>
<p>## Удаляем старые ядра от Centos 7</p>
<pre><code>
$ sudo rpm -e `rpm -q kernel`
</code></pre>
<p>## Удаляем пакеты, которые могут конфликтовать</p>
<div class="code-block code-block-3" style="margin: 8px 0; clear: both;">
<ins class="adsbygoogle" style="display:block" data-ad-client="ca-pub-1734532251661952" data-ad-slot="5888663144" data-ad-format="auto" data-full-width-responsive="true"></ins></div>
<pre><code>
$ sudo rpm -e --nodeps sysvinit-tools
</code></pre>
<p>## Запускаем обновление системы</p>
<pre><code>
$ sudo dnf -y --releasever=8 --allowerasing --setopt=deltarpm=false distro-sync
</code></pre>
<blockquote class="wp-block-quote is-style-danger">
<p>## На этом моменте у меня возникла ошибка зависимостей</p>
</blockquote>
<pre><code>
python3-rpmconf-1.0.21-1.el8.noarch conflicts with file from package python36-rpmconf-1.0.22-1.el7.noarch
</code></pre>
<p>## Решение:</p>
<pre><code>
$ sudo dnf -y remove python36-rpmconf
</code></pre>

<h3>## Ядро для Centos 8</h3>
<p>## Устанавливаем новое ядро для CentOS 8</p>
<pre><code>
$ sudo dnf -y install kernel-core
</code></pre>
<p>## Устанавливаем минимальный набор пакетов через групповое управление</p>
<pre><code>
$ sudo dnf -y groupupdate "Core" "Minimal Install"
</code></pre>
<p>## Проверяем, какая версия centos установилась</p>
<div class="code-block code-block-3" style="margin: 8px 0; clear: both;">
<ins class="adsbygoogle" style="display:block" data-ad-client="ca-pub-1734532251661952" data-ad-slot="5888663144" data-ad-format="auto" data-full-width-responsive="true"></ins></div>
<pre><code>
$ cat /etc/*release
</code></pre>
<p>## Удаляем временные файлы</p>
<pre><code>
$ sudo dnf clean all
</code></pre>

<h3>## Ошибка при установке YUM</h3>
<p>## При установке возникла ошибка</p>
<p>## Решение</p>
<pre><code>
$ cd /usr/bin
$ sudo ln -s dnf-3 yum
$ cd /etc/yum
$ sudo rm -r *
$ sudo dnf -y install yum
</code></pre>
</div>
