---
title: Docker-LAMP开发环境
toc: true
comments: true
share: true
date: 2018-01-02 17:53:04
tags:
 - Docker
categories:
 - Docker
---

## 1.选择镜像

我选择了start 比较多的一个<code>linode/lamp</code>

```
docker search lamp

$ docker search lamp
NAME                                   DESCRIPTION                                     STARS     OFFICIAL   AUTOMATED
linode/lamp                            LAMP on Ubuntu 14.04.1 LTS Container            110
...
```

## 2.下载镜像

```
docker pull linode/lamp
```

## 3.启动Ubuntu镜像

```
sudo docker run -p 80:80 -p 3306:3306 -v /your/path/www:/var/www -v /your/path/apache2.conf:/etc/apache2/apache2.conf -v /your/path/my.cnf:/etc/mysql/my.cnf -t -i linode/lamp /bin/bash

#解释：
docker run：运行一个container，如果后面要绑定宿主主机的0-1024端口需要使用sudo
-p port1:port2: 将宿主机的端口port1映射到容器中的port2
-v file1:file2: 将宿主机的文件\路径挂载到容器中的文件\路径
-t -i linode/lamp /bin/bash：使用linode/lamp生成容器，并打开shell
```

## 4.修改镜像

```
apt-get update 

apt-get install vim

apt-get install libapache2-mod-php5 php5 php5-gd php5-mysql

```

更新源列表，安装vim方便编辑，因为镜像默认已经安装好了apache，php，mysql还需要几个扩展。

## 5.保存镜像

```
docker ps #找到刚才操作的容器

docker commit 容器ID   mylamp:mysqli-vim

docker images

REPOSITORY          TAG                 IMAGE ID            CREATED                  SIZE
mylamp              mysqli-vim          ee713a48dbef        Less than a second ago   473MB
linode/lamp         mysqli              5fc7b9d4207d        5 hours ago              430MB
linode/lamp         latest              2359fa12fded        2 years ago              372MB
```

## 5.物理机映射

为了方便管理配置以及项目我的目录如下：

![](http://static.golangtab.com/images/2017-11/WX20180104-1139102x.png)

www目录下存放项目代码，外层是apache配置，mysql配置等等。apache2.conf可以copy一份放到这里，下面是我的一个vhost。

```
<VirtualHost *:80>
        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/example.com/public_html
        ServerName admin.xxxx.com

        <Directory "/var/www/example.com/public_html">
                Options  FollowSymLinks
                AllowOverride None
                Order allow,deny
                Allow from all
                DirectoryIndex index.html index.php
                
               # RewriteEngine off
               # RewriteCond %{REQUEST_URI} !^(/index\.php|/static/|/app/|/upload/|/robots\.txt)
               # RewriteRule ^(.*)$ /index.php/$1 [L]
                
                RewriteEngine On
                RewriteBase /
                RewriteRule ^index\.php$ - [L]
                RewriteCond %{REQUEST_FILENAME} !-f
                RewriteCond %{REQUEST_FILENAME} !-d
                RewriteRule . /index.php [L]
        </Directory>

          ErrorLog  /var/www/example.com/log/error.log
          CustomLog /var/www/example.com/log/access.log combined
</VirtualHost>
```

## 6.启动

```
docker run -p 80:80 -v /Users/zhen/www-root/work/:/var/www/ -v /Users/zhen/docker/lamp/sites-available:/etc/apache2/sites-available -v /Users/zhen/docker/lamp/log:/var/log/apache2 -v /Users/zhen/docker/lamp/sites-enabled:/etc/apache2/sites-enabled/ -t -i 你的镜像ID /bin/bash
```

由于我不需要本地mysql就没有做mysql映射配置。由于我还没看如何启动容器，服务自动启动还需要进入容器手动加载。

## 7.启动apache的rewrite

```
#使vhost生效 如果你跟我一样映射了site-enabled目录无需该步（手动添加vhost）
#sudo a2ensite xxxx.conf

sudo a2enmod rewrite

service apache2 restart
```

## 8.添加物理机hosts

绑定hosts，没什么好说的。

## 9.访问物理机地址

访问绑定的hosts的虚拟地址。





