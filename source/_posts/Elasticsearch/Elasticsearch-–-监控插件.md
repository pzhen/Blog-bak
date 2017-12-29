---
title: Es - 监控插件
toc: true
comments: true
share: true
date: 2017-11-07 14:22:27
tags:
 - Elasticsearch
 - Es
 - paramedic
categories:
 - Elasticsearch
---

来介绍一个Es的监控插件。通过插件可以观察到集群的状态以及各个索引的状态信息。<!-- more -->

```
bin/plugin install karmi/elasticsearch-paramedic
```

重启Es，访问:

```
http://127.0.0.1:9200/_plugin/paramedic/
```

效果如图：

![paramedic](http://static.golangtab.com/images/2017-10/WX20171107-1426312x.png)



