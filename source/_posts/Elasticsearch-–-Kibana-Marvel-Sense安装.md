---
title: Es – Kibana/Marvel/Sense安装
toc: true
comments: true
share: true
description: false
date: 2017-12-22 12:19:38
tags:
 - Elasticsearch
 - Es
categories:
 - Elasticsearch
---

## 环境

最近又要搞Es......,我的Es版本是2.3.3,如果高版本的请参考其他资料。

## 安装

### 1. 安装elasticsearch

下载elasticsearch2.3.3安装包。

下载地址：[elasticsearch-2.3.3.tar.gz](https://download.elastic.co/elasticsearch/release/org/elasticsearch/distribution/tar/elasticsearch/2.3.3/elasticsearch-2.3.3.tar.gz)

在安装目录解压即可。


### 2. 安装kibana插件

下载kibana4.5.1安装包

下载地址：[kibana-4.5.1-linux-x64.tar.gz](https://download.elastic.co/kibana/kibana/kibana-4.5.1-linux-x64.tar.gz)

在安装目录解压即可。


### 3. 安装elasticsearch-head插件

下载elasticsearch-head安装包。

下载地址：[elasticsearch-head.zip](https://github.com/mobz/elasticsearch-head/archive/master.zip)

到$ES_HOME（elasticsearch的主目录，下同），执行命令： bin/plugin install file:/home/××/elasticsearch-head.zip ,注：file后面为插件所在的绝对或者相对路径，下同。

### 4. 安装marvel插件

下载license、marvel-agent、marvel安装包。

下载地址：[license-2.3.3.zip](https://download.elastic.co/elasticsearch/release/org/elasticsearch/plugin/license/2.3.3/license-2.3.3.zip)、[marvel-agent-2.3.3.zip](https://download.elastic.co/elasticsearch/release/org/elasticsearch/plugin/marvel-agent/2.3.3/marvel-agent-2.3.3.zip)、[marvel-2.3.3.tar.gz](https://download.elasticsearch.org/elasticsearch/marvel/marvel-2.3.3.tar.gz)。

到$ES_HOME，执行命令：bin/plugin install file:/home/××/license-2.3.3.zip和/bin/plugin install file:/home/××/marvel-agent-2.3.3.zip

也可以：./kibana-4.5.1-linux-x64/bin/kibana plugin—install elasticsearch/marvel/latest

到$KIBANA_HOME(为kibana的主目录，下同)，执行命令bin/kibana plugin -i marvel -u file:/home/××/marvel-latest.zip

### 5. 安装sense插件

下载sense安装包。下载地址：[sense-latest.tar.gz](https://download.elastic.co/elastic/sense/sense-latest.tar.gz)

到$KIBANA_HOME，执行命令：bin/kibana plugin -i sense -u file:/home/××/sense-latest.tar.gz

 

### 6. 安装sql插件

下载elasticsearch-sql-2.3.3.0安装包。

下载地址：[elasticsearch-sql-2.3.3.0.zip](https://github.com/NLPchina/elasticsearch-sql/releases/download/2.3.3.0/elasticsearch-sql-2.3.3.0.zip%20)（可能需要翻Q）

到$ES_HOME，执行命令： bin/plugin install file:/home/××/elasticsearch-sql-2.3.3.0.zip

可以参考wiki:[https://github.com/NLPchina/elasticsearch-sql/wiki](https://github.com/NLPchina/elasticsearch-sql/wiki)

 

7.安装jdbc插件

下载elasticsearch-jdbc-2.3.3.1-dist安装包。

下载地址：[elasticsearch-jdbc-2.3.3.1-dist.zip](http://xbib.org/repository/org/xbib/elasticsearch/importer/elasticsearch-jdbc/2.3.3.1/elasticsearch-jdbc-2.3.3.1-dist.zip)

在安装目录解压即可。

可以参考wiki:[https://github.com/jprante/elasticsearch-jdbc/wiki](https://github.com/jprante/elasticsearch-jdbc/wiki)


## 小结：其实就是将插件下载下来，解压到插件目录即可。


## 参考资料
> - [elasticsearch2.3.3以及其插件离线安装](http://blog.csdn.net/liyantianmin/article/details/58254620)
> - [elasticsearch2.3.3搭建及插件安装](http://blog.csdn.net/a1244271719/article/details/53908416)

