---
title: Es – Head安装插件
toc: true
date: 2017-07-21 16:23:35
share: true
tags:
 - Elasticsearch
 - Es
 - Ik 
 - 插件
categories:
 - Elasticsearch
---

由于Elasticsearch-head 插件不支持5.3.0，比较费事，装个低版本的，安装个插件。<!-- more -->

来看下 2.3.0 插件安装
```
./plugin install mobz/elasticsearch-head

http://localhost:9200/_plugin/head

```

安装 bigdesk 集群管理插件。

bigdesk是elasticsearch的一个集群监控工具，可以通过它来查看es集群的各种状态，如：cpu、内存使用情况，索引数据、搜索情况，http连接数等。项目git地址： https://github.com/lukas-vlcek/bigdesk。和head一样，它也是个独立的网页程序，使用方式和head一样。

1.下载bigdesk插件，bigdesk-master.zip。

2.复制到 es plugins 插件目录下
```
cp bigdesk-master.zip  elasticsearch-2.3.0/plugins
```
3.解压 删除
```
unzip bigdesk-master.zip 

rm -rf bigdesk-master.zip 
```
4.创建 _site 文件夹
```
cd bigdesk-master
mkdir _site
```
将 bigdesk-master 下刚刚解压的文件移动到 _site 下面。

4.创建 plugin-descriptor.properties 文件

添加一下内容：

```
description=bigdesk
version=bigdesk
name=bigdesk
site=true

```

5.修改js文件。

定位到plugins/bigdesk/_site/js/store目录，打开BigdeskStore.js，定位到142行

把 major ==1 改成 major >=1，然后保存

6.搞定，浏览器查看
```
http://localhost:9200/_plugin/bigdesk-master/#nodes
```
最后附上我的目录结构：


![](http://static.golangtab.com/images/2017-08/E9B80FA8-56F0-49DE-85E0-129215E63B28.jpg)