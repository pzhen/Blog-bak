---
title: Es - ELK 环境搭建
toc: true
comments: true
share: true
date: 2017-09-19 16:53:28
tags:
 - Es
 - Elasticsearch
 - Elk
categories:
 - Elasticsearch
---

ELK 环境搭建<!-- more -->

### 1. 环境准备

Mac 系统

JDK 环境

elasticsearch-2.4.0.zip

kibana-4.6.1-darwin-x86_64.tar.gz  选择的Mac版本。

logstash-2.4.0.tar.gz



### 2. Elasticsearch 安装 

前面有 Es [安装博文](http://www.golangtab.com/2017/07/20/Elasticsearch-%E2%80%93-%E5%AE%89%E8%A3%85/) ，在这里不在重复。

### 3. logstash 安装

解压 ，然后创建配置文件，由于没安装Nginx,这里添加 Apache 的日志，来测试。

```
tar -zxvf logstash-2.4.0.tar.gz 

跟目录下创建: logstash-simple.conf  添加：

input {
	file { 
		type => "apache_log" 
		tags => ["apache"] 
		path => ["/Users/zhen/tmp/apache-log/*.log"] 
		start_position => beginning 
		ignore_older => 0 
	} 
} 
 
 
output {
	elasticsearch { 
	hosts => [ "127.0.0.1:9200" ] 
} 
 
} 
```
启动：

```
./bin/logstash agent -f logstash-simple.conf
```

### 4. kibana 安装

同理解压 然后修改配置文件，确保可以访问到Es

vim ./config/kibana.yml

```
server.host: "127.0.0.1"

elasticsearch.url: "http://127.0.0.1:9200"
```
启动：

```
./bin/kibana
```

我添加的是apache的日志，也可以添加 Mysql 慢查询日志，Nginx 日志等。

kibana 具体内容不展示了，简单截图如下：

![](http://static.golangtab.com/images/2017-08/WX20170919-1714322x.png)

### 5. 高版本的ELK安装方法同理可以参考下面的博客。

## 参考资料
> - [Centos7安装配置ELK（Elasticsearch + Logstash + Kibana）分析Nginx日志简单单点配置](https://yq.aliyun.com/articles/201193?spm=5176.100240.searchblog.22.zRmVOi)













