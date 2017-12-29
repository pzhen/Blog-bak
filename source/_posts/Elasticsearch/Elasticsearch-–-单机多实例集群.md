---
title: Es - 单机多实例集群
toc: true
comments: true
share: true
date: 2017-08-23 11:15:44
tags:
 - Elasticsearch
 - Es
 - Ik 
 - 集群
categories:
 - Elasticsearch
---

Es 启动多个实例来构建多个服务,来构成集群，这就需要每个实例有单独的 config,logs,data 目录，每个实例独立。<!-- more -->


#### 1.在config目录下创建三个实例的配置目录

```
zhen@zhen-Mac: /Users/zhen/opt/elasticsearch-2.3.0/config
➜  ll
total 16
drwxr-xr-x  5 zhen  staff   170B  8 22 14:32 instance1
drwxr-xr-x  5 zhen  staff   170B  8 22 14:34 instance2
drwxr-xr-x  6 zhen  staff   204B  8 22 15:24 instance3

```
#### 2.创建实例所需配置

将 config目录下默认的 elasticsearch.yml logging.yml 分别复制到instance1，instance2，instance3


#### 3.数据data目录下同理创建三个实例目录

```
zhen@zhen-Mac: /Users/zhen/opt/elasticsearch-2.3.0
➜  ll data
total 0
drwxr-xr-x  3 zhen  staff   102B  8 22 14:32 instance1
drwxr-xr-x  3 zhen  staff   102B  8 22 14:34 instance2
drwxr-xr-x  2 zhen  staff    68B  8 22 15:20 instance3
```

#### 4.修改配置文件

instance1 elasticsearch.yml

```
cluster.name: my-es
node.name: node-1
node.data: true
node.master: false
path.data: /Users/zhen/opt/elasticsearch-2.3.0/data/instance1
path.logs: /Users/zhen/opt/elasticsearch-2.3.0/logs/instance1
network.host: 0.0.0.0
http.port: 9200
transport.tcp.port: 9300
discovery.zen.ping.unicast.hosts: ["127.0.0.1:9301","127.0.0.1:9302"]
discovery.zen.ping.multicast.enabled: true
node.max_local_storage_nodes: 2
```

instance2 elasticsearch.yml

```
cluster.name: my-es
node.name: node-2
node.data: true
node.master: false
path.data: /Users/zhen/opt/elasticsearch-2.3.0/data/instance2
path.logs: /Users/zhen/opt/elasticsearch-2.3.0/logs/instance2
network.host: 0.0.0.0
http.port: 9201
transport.tcp.port: 9301
discovery.zen.ping.unicast.hosts: ["127.0.0.1:9300","127.0.0.1:9302"]
discovery.zen.ping.multicast.enabled: true
node.max_local_storage_nodes: 2
```

instance3 elasticsearch.yml

```
cluster.name: my-es
node.name: node-3
node.data: true
node.master: false
path.data: /Users/zhen/opt/elasticsearch-2.3.0/data/instance3
path.logs: /Users/zhen/opt/elasticsearch-2.3.0/logs/instance3
network.host: 0.0.0.0
http.port: 9202
transport.tcp.port: 9302
discovery.zen.ping.unicast.hosts: ["127.0.0.1:9300","127.0.0.1:9301"]
discovery.zen.ping.multicast.enabled: true
node.max_local_storage_nodes: 2
```

#### 4.启动实例脚本

```
bin/elasticsearch -Des.path.conf=config/instance1

bin/elasticsearch -Des.path.conf=config/instance2

bin/elasticsearch -Des.path.conf=config/instance3
```