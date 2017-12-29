---
title: Ubuntu - Jdk 安装
toc: true
date: 2017-07-20 10:32:47
share: true
tags:
 - Jdk
 - Linux
 - Ubuntu
categories:
 - Linux
 - Jdk
---

Ubuntu 下安装 jdk <!-- more -->

#### 1.解压
```
sudo tar zxvf ./jdk-7u45-linux-x64.tar.gz
```
#### 2.环境变量
```
vi ~/.bashrc 或者 ~/.zshrc

export JAVA_HOME=/opt/Java/jdk/jdk1.7 
export CLASSPATH=${JAVA_HOME}/lib
export PATH=${JAVA_HOME}/bin:$PATH
```
#### 3.立即生效
```
source ~/.bashrc
```
