---
title: Redis - PHP7扩展
toc: true
date: 2017-07-20 10:39:26
share: true
tags:
 - Php
 - Redis
categories:
 - Redis
---

下载  https://github.com/phpredis/phpredis/tree/php7

解压  unzip phpredis-php7.zip

phpize  #用phpize生成configure配置文件

./configure  配置

make  #编译

make install  #安装

安装完成后将出现的安装路径添加到php.ini中:

extension_dir = "/usr/lib/php/20151012"

extension = redis.so

重启服务器,查看phpinfo,是不是搞定.

