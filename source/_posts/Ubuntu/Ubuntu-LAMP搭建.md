---
title: Ubuntu - LAMP搭建
toc: true
date: 2017-08-02 10:21:39
share: true
tags:
 - Php
 - LAMP
 - Ubuntu
categories:
 - Linux
 - LAMP
---

### 安装过程
第一步 安装Apache2
sudo apt-get install apache2
第二步 安装PHP模块
sudo apt-get install php5
第三步 安装Mysql
sudo apt-get install mysql-server
sudo apt-get install mysql-client
第四步 其他模块安装<!-- more -->
sudo apt-get install libapache2-mod-php5
sudo apt-get install libapache2-mod-auth-mysql
sudo apt-get install php5-mysql
sudo apt-get install php5-gd
第五步 测试Apache是否正常工作
打开浏览器，输入localhost，看看是否有It Works!网页展示。目录为/var/www
第六步 修改权限/var/www
sudo chomod 777 /var/www
第七步 安装phpmyadmin
sudo apt-get install phpmyadmin
安装过程中选择apache2，点击确定。下一步选择是要配置数据库，并输入密码。
第八步 测试phpmyadmin

### 配置过程
第一步 启用mod_rewrite模块
sudo a2enmod rewrite
重启Apache服务器：sudo
/etc/init.d/apache2
restart或者sudo service apache2 restart

第二步 设置Apache支持.htm .html .php
第三步 测试php网页
编辑mysql_test.php代码如下：
<?php
$link = mysql_connect("localhost", "root", "password");
if(!$link)
die('Could not connect: ' . mysql_error());
else
echo "Mysql 配置正确!";
mysql_close($link);
?>
访问 http://localhost/mysql_test.php 显示’Mysql 配置正确‘就代表配置正确。
第四步 第三步这里出现了乱码以后解决方法
到此为止配置OK。

