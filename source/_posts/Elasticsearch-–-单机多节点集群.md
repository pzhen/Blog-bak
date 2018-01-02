---
title: Es - 单机多节点集群
toc: true
date: 2017-07-21 16:11:43
tags:
 - Elasticsearch
 - Es
 - Ik 
 - 集群
categories:
 - Elasticsearch
share: true
---

来看下单机多节点集群的环境搭建。<!-- more -->

#### 采用版本

1.物理机 Mac

2.Elasticsearch 2.3.0

3.插件：head，bigdesk

4.部署4个节点：2个数据节点，1个主节点，1个备用主节点

#### 部署

请到 GitHub 下载 ES 2.3.0 版本

https://github.com/elastic/elasticsearch/tree/v2.3.0

##### 解压

请根据自己部署软件的习惯解压到合适目录，下面是我的本机目录：

/Users/zhen/opt/es-cloud-2.3.0

es-cloud-2.3.0 文件夹放置的单机的4个节点目录，附上我的目录结构：

![image](http://static.golangtab.com/images/2017-08/WX20170509-2323572x.png)

从图中大家也了解了，其实就是复制出4份来，只不过每个ES里面的配置不一样。

插件安装前面已经介绍过了，请看 这里 ，可以先安装master的插件，安转完成再复制就好了。


##### 各个节点的配置

主节点master：

``` shell
cluster.name: my-es
#主节点
node.name: master
node.master: true
#数据节点
node.data: false
network.host: 0.0.0.0
http.port: 9200
transport.tcp.port: 9300
#集群节点列表
discovery.zen.ping.unicast.hosts: ["127.0.0.1:9300","127.0.0.1:9303","127.0.0.1:9301","127.0.0.1:9302"]
#多播，单机的话无所谓了
discovery.zen.ping.multicast.enabled: true
#集群限制节点的个数
node.max_local_storage_nodes: 10
```


数据节点data-1：

``` shell
cluster.name: my-es
#主节点
node.name: data-1
node.master: false
#数据节点
node.data: true
network.host: 0.0.0.0
http.port: 9201
transport.tcp.port: 9301
#集群节点列表
discovery.zen.ping.unicast.hosts: ["127.0.0.1:9300","127.0.0.1:9303","127.0.0.1:9301","127.0.0.1:9302"]
#多播，单机的话无所谓了
discovery.zen.ping.multicast.enabled: true
#集群限制节点的个数
node.max_local_storage_nodes: 10

```

数据节点data-2：

``` shell
cluster.name: my-es
#主节点
node.name: data-2
node.master: false
#数据节点
node.data: true
network.host: 0.0.0.0
http.port: 9202
transport.tcp.port: 9302
#集群节点列表
discovery.zen.ping.unicast.hosts: ["127.0.0.1:9300","127.0.0.1:9303","127.0.0.1:9301","127.0.0.1:9302"]
#多播，单机的话无所谓了
discovery.zen.ping.multicast.enabled: true
#集群限制节点的个数
node.max_local_storage_nodes: 10
```
备用主节点：

``` shell
cluster.name: my-es
#主节点
node.name: client-1
node.master: true
#数据节点
node.data: false
network.host: 0.0.0.0
http.port: 9203
transport.tcp.port: 9303
#集群节点列表
discovery.zen.ping.unicast.hosts: ["127.0.0.1:9300","127.0.0.1:9303","127.0.0.1:9301","127.0.0.1:9302"]
#多播，单机的话无所谓了
discovery.zen.ping.multicast.enabled: true
#集群限制节点的个数
node.max_local_storage_nodes: 10
```
##### 启动

启动节点，写到脚本里面执行，不用一条条的运行了。

``` shell
./es-node-master/bin/elasticsearch -d

./es-node-data-1/bin/elasticsearch -d

./es-node-data-2/bin/elasticsearch -d

./es-node-client/bin/elasticsearch -d

```

##### 查看集群状态：
![image](http://static.golangtab.com/images/2017-08/WX20170509-224809zhu.png)

##### 测试

假如我们挂掉主节点，再来看看我们的集群状态。

![image](http://static.golangtab.com/images/2017-08/WX20170509-2250282x.png)


当我们挂掉了master，访问任意一个节点的head插件，来看集群状态。选举了client-1为主节点。

最后附上bigdesk的截图：

![image](http://static.golangtab.com/images/2017-08/2A230B92-4278-4C3D-8001-19CB858086AD.jpg)