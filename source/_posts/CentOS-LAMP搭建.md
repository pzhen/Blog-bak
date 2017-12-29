---
title: CentOS - LAMP搭建
toc: true
date: 2017-08-07 10:48:35
tags:
 - Php
 - LAMP
 - CentOS
categories:
 - Linux
 - LAMP
share: true
---

### centos 6.4 yum搭建lamp环境 
<!-- more -->
1、配置防火墙，开启80端口、3306端口

vi /etc/sysconfig/iptables

-A INPUT -m state --state NEW -m tcp -p tcp --dport 80 -j ACCEPT #允许80端口通过防火墙

-A INPUT -m state --state NEW -m tcp -p tcp --dport 3306 -j ACCEPT #允许3306端口通过防火墙

备注：很多网友把这两条规则添加到防火墙配置的最后一行，导致防火墙启动失败，

正确的应该是添加到默认的22端口这条规则的下面

如下所示：

############################## 添加好之后防火墙规则如下所示 ##############################

Firewall configuration written by system-config-firewall

Manual customization of this file is not recommended.

*filter

:INPUT ACCEPT [0:0]

:FORWARD ACCEPT [0:0]

:OUTPUT ACCEPT [0:0]

-A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

-A INPUT -p icmp -j ACCEPT

-A INPUT -i lo -j ACCEPT

-A INPUT -m state --state NEW -m tcp -p tcp --dport 22 -j ACCEPT

-A INPUT -m state --state NEW -m tcp -p tcp --dport 80 -j ACCEPT

-A INPUT -m state --state NEW -m tcp -p tcp --dport 3306 -j ACCEPT

-A INPUT -j REJECT --reject-with icmp-host-prohibited

-A FORWARD -j REJECT --reject-with icmp-host-prohibited

COMMIT

###################################################################################

/etc/init.d/iptables restart #最后重启防火墙使配置生效

2、关闭SELINUX

vi /etc/selinux/config

#SELINUX=enforcing #注释掉

#SELINUXTYPE=targeted #注释掉

SELINUX=disabled #增加

:wq #保存，关闭

shutdown -r now #重启系统

安装篇：

一、安装Apache

yum install httpd #根据提示，输入Y安装即可成功安装

/etc/init.d/httpd start #启动Apache

备注：Apache启动之后会提示错误：

正在启动 httpd:httpd: Could not reliably determine the server's fully qualif domain name, using ::1 for ServerName

解决办法：

vi /etc/httpd/conf/httpd.conf #编辑

找到 #ServerName www.example.com:80

修改为 ServerName www.osyunwei.com:80 #这里设置为你自己的域名，如果没有域名，可以设置为localhost:wq! #保存退出

chkconfig httpd on #设为开机启动

/etc/init.d/httpd restart #重启Apache

二、安装MySQL

1、安装MySQL

yum install mysql mysql-server #询问是否要安装，输入Y即可自动安装,直到安装完成

/etc/init.d/mysqld start #启动MySQL

chkconfig mysqld on #设为开机启动

cp /usr/share/mysql/my-medium.cnf /etc/my.cnf #拷贝配置文件（注意：如果/etc目录下面默认有一个my.cnf，直接覆盖即可）

2、为root账户设置密码

mysql_secure_installation

回车，根据提示输入Y

输入2次密码，回车

根据提示一路输入Y

最后出现：Thanks for using MySQL!

MySql密码设置完成，重新启动 MySQL：

/etc/init.d/mysqld restart #重启

/etc/init.d/mysqld stop #停止

/etc/init.d/mysqld start #启动

允许远程登录

mysql -u root -p

Enter Password: <your new password>

mysql>GRANT ALL PRIVILEGES ON . TO '用户名'@'%' IDENTIFIED BY '密码' WITH GRANT OPTION;

完成后就能用mysql-front远程管理mysql了

详细出处参考：http://www.jb51.net/article/24775.htm

解决 Access denied for user ''@'localhost' to database 'mysql' 今天给服务器更新mysql，用源代码编译安装，在导入数据后发现没有将mysql加入系统服务，于是加上服务。加上之后在登录，结果不用密码就能登进去，而root明明是有密码的。用select user()命令查看当前登录用户是root。

查看数据库，只能看到自带的两个，mysql这个数据库都看不到。如果运行use mysql，就会出现 Access denied for user ''@'localhost' to database 'mysql'， 这说明这是匿名登录的，几乎什么权限都没有。即使用mysql -u root登录也是这个样子，不知道是不是一个bug。

在 网上查了半天，找到了解决办法。首先停止mysqld服务，然后后台运行mysqld_safe --skip-grant-tables &, 再用root登录，就一切正常了。网上说只要改了root密码就好了，我的却不行。干脆把user表里的匿名用户删了，反正也不用匿名登录。然后在登录就 好了

三、安装PHP5

1、安装PHP5

yum install php

根据提示输入Y直到安装完成

2、安装PHP组件，使 PHP5 支持 MySQL

yum install php-mysql php-gd libjpeg* php-imap php-ldap php-odbc php-pear php-xml php-xmlrpc php-mbstring php-mcrypt php-bcmath php-mhash libmcrypt

这里选择以上安装包进行安装

根据提示输入Y回车

/etc/init.d/mysqld restart #重启MySql

/etc/init.d/httpd restart #重启Apche

配置篇

一、Apache配置

vi /etc/httpd/conf/httpd.conf #编辑文件

ServerTokens OS　 在44行 修改为：ServerTokens Prod （在出现错误页的时候不显示服务器操作系统的名称）

ServerSignature On　 在536行 修改为：ServerSignature Off （在错误页中不显示Apache的版本）

Options Indexes FollowSymLinks　 在331行 修改为：Options Includes ExecCGI FollowSymLinks（允许服务器执行CGI及SSI，禁止列出目录）

#AddHandler cgi-script .cgi　在796行 修改为：AddHandler cgi-script .cgi .pl （允许扩展名为.pl的CGI脚本运行）

AllowOverride None　 在338行 修改为：AllowOverride All （允许.htaccess）

AddDefaultCharset UTF-8　在759行 修改为：AddDefaultCharset GB2312　（添加GB2312为默认编码）

Options Indexes MultiViews FollowSymLinks 在554行 修改为 Options MultiViews FollowSymLinks（不在浏览器上显示树状目录结构）

DirectoryIndex index.html index.html.var 在402行 修改为：DirectoryIndex index.html index.htm Default.html Default.htm

index.php Default.php index.html.var （设置默认首页文件，增加index.php）

KeepAlive Off 在76行 修改为：KeepAlive On （允许程序性联机）

MaxKeepAliveRequests 100 在83行 修改为：MaxKeepAliveRequests 1000 （增加同时连接数）

:wq! #保存退出

/etc/init.d/httpd restart #重启

rm -f /etc/httpd/conf.d/welcome.conf /var/www/error/noindex.html #删除默认测试页

二、php配置

vi /etc/php.ini #编辑

date.timezone = PRC #在946行 把前面的分号去掉，改为date.timezone = PRC

disable_functions = passthru,exec,system,chroot,scandir,chgrp,chown,shell_exec,proc_open,proc_get_status,ini_alter,ini_alter,ini_restore,dl,openlog,syslog,readlink,symlink,popepassthru,stream_socket_server,escapeshellcmd,dll,popen,disk_free_space,checkdnsrr,checkdnsrr,getservbyname,getservbyport,disk_total_space,posix_ctermid,posix_get_last_error,posix_getcwd, posix_getegid,posix_geteuid,posix_getgid, posix_getgrgid,posix_getgrnam,posix_getgroups,posix_getlogin,posix_getpgid,posix_getpgrp,posix_getpid, posix_getppid,posix_getpwnam,posix_getpwuid, posix_getrlimit, posix_getsid,posix_getuid,posix_isatty, posix_kill,posix_mkfifo,posix_setegid,posix_seteuid,posix_setgid, posix_setpgid,posix_setsid,posix_setuid,posix_strerror,posix_times,posix_ttyname,posix_uname

#在386行 列出PHP可以禁用的函数，如果某些程序需要用到这个函数，可以删除，取消禁用。

expose_php = Off #在432行 禁止显示php版本的信息

magic_quotes_gpc = On #在745行 打开magic_quotes_gpc来防止SQL注入

short_open_tag = ON #在229行支持php短标签

open_basedir = .:/tmp/ #在380行 设置表示允许访问当前目录(即PHP脚本文件所在之目录)和/tmp/目录,可以防止php木马跨站,如果改了之后安装程序有问题(例如：织梦内容管理系 统)，可以注销此行，或者直接写上程序的目录/data/www.osyunwei.com/:/tmp/

:wq! #保存退出

/etc/init.d/mysqld restart #重启MySql

/etc/init.d/httpd restart #重启Apche

测试篇

cd /var/www/html

vi index.php #输入下面内容

<?php

phpinfo();

?>

:wq! #保存退出

详细出处参考：http://www.jb51.net/article/37987.htm

安装Apahce, PHP, MySQL以及php连接mysql库组件。 #yum -y install httpd php mysql mysql-server php-mysql yum会到指定的服务器(mirror:163.com服务器)下载对应的软件版本，并自动处理依赖关系，并进行安装。

安装apache扩展 #yum -y install httpd-manual mod_ssl mod_perl mod_auth_mysql 让apache更好的支持其他的软件。

安装php的扩展 #yum -y install php-gd php-xml php-mbstring php-ldap php-pear php-xmlrpc apache本身并不支持php文件，要安装对应的php软件，然后进行http.conf配置；让apache能解析.php文件。

安装MySQL的扩展 #yum -y install mysql-connector-odbc mysql-devel libdbi-dbd-mysql 跟好的实现mysql的功能。

配置开机启动服务 #/sbin/chkconfig httpd on [设置apache服务器httpd服务开机启动] #/sbin/service httpd start [启动httpd服务,与开机启动无关] #/sbin/service mysqld start [启动mysqld服务,与开机启动无关]

简单配置文件： apache的配置文件是/etc/httpd/conf下 modules放在/usr/lib/httpd下 php的配置文件在/etc/php.d/下 和/etc/php.ini php的modules放在/usr/lib/php/modules下

安装Tomcat5 #yum -y install tomcat5 tomcat5-webapps tomcat5-admin-webapps 安装Tomcat5安装包和对应的依赖关系包

启动Tomcat5 #service tomcat5 start #chkconfig tomcat5 on

在浏览器输入http://你的IP:8080/,可以看到Apache SoftWare Foundation页，如果看不到，请确认是否是防火墙问题 看到一个猫头 ------------------>tomcat5安装成功

Apache与Tomcat整合 如果网站需同时整合Apache与Tomcat可以使用JK或者Proxy方式 使用VI编辑proxy_ajp.conf文件 #vi /etc/httpd/conf.d/proxy_ajp.conf 输入以下内容 ProxyPass /tomcat/ ajp://localhost:8009/ 存储文件后，重启Apache

#service httpd restart

在浏览器输入http://你的IP/tomcat/,可以看到Apache SoftWare Foundation页 As you may have guessed by now, this is the default Tomcat home page. It can be found on the local filesystem at:

$CATALINA_HOME/webapps/ROOT/index.jsp

这样就可以解析 .jsp文件。


