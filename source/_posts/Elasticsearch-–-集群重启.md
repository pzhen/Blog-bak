---
title: Es – 集群重启
toc: true
comments: true
share: true
date: 2017-09-11 17:23:37
tags:
 - Elasticsearch
 - 集群
categories:
 - Elasticsearch
---
来看下集群的重启。<!-- more -->

### ES 集群重启

- 1.关闭分片分配

当试图关闭某个节点时候，ES会试图将该节点下的数据复制到其他节点上，这就会造成大量的IO请求，所以为了避免这种情况，关闭节点之前关闭自动复制。

```
PUT /_cluster/settings
{
    "transient" : {
        "cluster.routing.allocation.enable" : "none"
    }
}
```

- 2.手动执行同步刷新

```
POST /_flush/synced
```

- 3.关闭节点来升级

- 4.启动集群

先启动 node.master 节点，陆续启动数据节点逐渐构建成集群。启动过程中查看集群的健康状态，由红色变为黄色，主节点都可以使用，延迟副本分片分配。

```
GET _cat/health
GET _cat/nodes
```
- 5.重新分配

启动分片碎片分配

```
PUT /_cluster/settings
{
    "transient" : {
        "cluster.routing.allocation.enable" : "all"
    }
}
```



