---
title: MongoDB - PHP7扩展安装
toc: true
date: 2017-08-08 15:13:15
share: true
tags:
 - Php
 - MongoDB
 - 扩展
categories:
 - MongoDB
---

## Mac 下 php7 安装 MongoDB 扩展。<!-- more -->

#### 下载扩展的源码包 [mongodb-1.2.9.tar](/software/mongodb-1.2.9.tar)

#### 关闭apahce

#### 开始安装

``` shell
tar -zxvf mongodb-1.2.9.tar

phpize

sudo ./configure --with-php-config=/usr/local/Cellar/php70/7.0.15_8/bin/php-config --with-openssl-dir=/usr/local/Cellar/openssl/1.0.2j

注：如果不指定 --with-openssl-dir=/usr/local/Cellar/openssl/1.0.2j 会报错:

mac  configure: error: Cannot find OpenSSL's <evp.h>

sudo make

sudo make install

vim /usr/local/etc/php/7.0/php.ini

extension=mongodb.so

注意你的 extension_dir = "ext" 这个配置路径，我采用的phpize默认的生成扩展的路径。

extension_dir = "/usr/local/Cellar/php70/7.0.15_8/lib/php/extensions/no-debug-non-zts-20151012/"

```
