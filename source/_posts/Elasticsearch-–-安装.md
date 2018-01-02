---
title: Es – 安装
toc: true
date: 2017-07-20 15:54:38
tags:
 - Elasticsearch
 - Es
 - Linux
categories:
 - Elasticsearch
share: true
---

由于高版本提高了安全级别，不能采用root账户启动.<!-- more -->

#### 下载

下载地址：https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-5.3.0.zip

#### 解压后执行

```
./bin/elasticsearch
```

#### 错误处理

##### 错误提示
```
Exception in thread "main" java.lang.RuntimeException: don't run elasticsearch as root.
        at org.elasticsearch.bootstrap.Bootstrap.initializeNatives(Bootstrap.java:93)
        at org.elasticsearch.bootstrap.Bootstrap.setup(Bootstrap.java:144)
        at org.elasticsearch.bootstrap.Bootstrap.init(Bootstrap.java:285)
        at org.elasticsearch.bootstrap.Elasticsearch.main(Elasticsearch.java:35)
Refer to the log for complete error details.
```
##### 解决错误

因为版本的问题，最新的版本安全级别提高了，不允许采用root帐号启动，所以我们要添加一个用户。

```
#添加一个用户：elasticsearch
$useradd elasticsearch
#给用户elasticsearch设置密码，连续输入2次
$passwd elasticsearch
#创建一个用户组 es
groupadd es
#分配 elasticsearch 到 es 组
usermod -G elasticsearch es
#这里注意下，如果提示用户“es”不存在，那么是因为服务器版本问题，你可以换成 usermod -G es elasticsearch ,也就是用户和用户组对调一下使用。
#在elasticsearch 根目录下，给定用户权限。-R表示逐级（N层目录） ， * 表示 任何文件
chown  -R elasticsearch.es *
#切换到elasticsearch用户
su elasticsearch

```

如果不按上面的给用户 elasticsearch  分配权限目录。那么会报下面的错。

```
java.io.FileNotFoundException: /home/es/elasticsearch-2.2.0/logs/elasticsearch.log (Permission denied)
        at java.io.FileOutputStream.open(Native Method)
        at java.io.FileOutputStream.(FileOutputStream.java:221)
        at java.io.FileOutputStream.(FileOutputStream.java:142)
        at org.apache.log4j.FileAppender.setFile(FileAppender.java:294)
        at org.apache.log4j.FileAppender.activateOptions(FileAppender.java:165)
        at org.apache.log4j.DailyRollingFileAppender.activateOptions(DailyRollingFileAppender.java:223)
        at org.apache.log4j.config.PropertySetter.activate(PropertySetter.java:307)
        at org.apache.log4j.config.PropertySetter.setProperties(PropertySetter.java:172)
        at org.apache.log4j.config.PropertySetter.setProperties(PropertySetter.java:104)
        at org.apache.log4j.PropertyConfigurator.parseAppender(PropertyConfigurator.java:842)
        at org.apache.log4j.PropertyConfigurator.parseCategory(PropertyConfigurator.java:768)
        at org.apache.log4j.PropertyConfigurator.configureRootCategory(PropertyConfigurator.java:648)
        at org.apache.log4j.PropertyConfigurator.doConfigure(PropertyConfigurator.java:514)
        at org.apache.log4j.PropertyConfigurator.configure(PropertyConfigurator.java:440)
        at org.elasticsearch.common.logging.log4j.LogConfigurator.configure(LogConfigurator.java:128)
        at org.elasticsearch.bootstrap.Bootstrap.setupLogging(Bootstrap.java:204)
        at org.elasticsearch.bootstrap.Bootstrap.init(Bootstrap.java:258)
        at org.elasticsearch.bootstrap.Elasticsearch.main(Elasticsearch.java:35)
log4j:ERROR Either File or DatePattern options are not set for appender [file].
log4j:ERROR setFile(null,true) call failed.
```

#### 修改配置文件

```
$ vi config/elasticsearch.yml
#cluster name
cluster.name: sojson-application
#节点名称
node.name: node-1
#绑定IP和端口
network.host: 123.88.88.88
http.port: 9200
```

#### 后台运行

```
./bin/elasticsearch -d
```

#### 查找进程
```
ps -ef | grep elasticsearch
```