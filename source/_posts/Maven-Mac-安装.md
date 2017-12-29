---
title: Maven - Mac 安装
toc: true
date: 2017-07-21 16:04:51
share: true
tags:
 - Linux
 - Maven
 - Java
categories:
 - Linux
 - Maven
---

1.下载maven

<!-- more -->

http://mirror.bit.edu.cn/apache/maven/maven-3/3.5.0/binaries/apache-maven-3.5.0-bin.zip

2.解压

unzip apache-maven-3.5.0-bin.zip

如果是tar.gz包

tar xzvf apache-maven-3.5.0-bin.tar.gz

3.配置环境变量

vim ~/.bash_profile

添加路径：

export PATH=/路径/apache-maven-3.5.0/bin:$PATH

4.查看

mvn -version

官方install地址：http://maven.apache.org/install.html
