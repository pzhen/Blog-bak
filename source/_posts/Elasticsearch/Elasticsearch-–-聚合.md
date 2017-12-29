---
title: Es - 聚合
toc: true
comments: true
share: true
date: 2017-10-17 10:58:19
tags:
 - Elasticsearch
 - Group
categories:
 - Elasticsearch
---

聚合提供了用户进行分组和数理统计的能力，可以把聚合理解成SQL中的GROUP BY和分组函数。在ES中，你可以在一次搜索查询的时间内，即完成搜索操作也完成聚合操作，这样就降低了多次使用REST API造成的网络开销。
<!-- more -->
下面就是通过terms聚合的简单样例：

```
curl -XPOST 'http://xxx.xxx.xxx.xxx:9200/comic/comic/_search' -d '
{
  "size": 0,
  "aggs": {
    "group_by_state": {
      "terms": {
        "field": "status"
      }
    }
  }
}
'
```

结果：

```
{
    "took": 98, 
    "timed_out": false, 
    "_shards": {
        "total": 5, 
        "successful": 5, 
        "failed": 0
    }, 
    "hits": {
        "total": 46075, 
        "max_score": 0, 
        "hits": [ ]
    }, 
    "aggregations": {
        "group_by_state": {
            "doc_count_error_upper_bound": 0, 
            "sum_other_doc_count": 0, 
            "buckets": [
                {
                    "key": 2, 
                    "doc_count": 17942
                }, 
                {
                    "key": 0, 
                    "doc_count": 3169
                }, 
                {
                    "key": 100, 
                    "doc_count": 2944
                }, 
                {
                    "key": 98, 
                    "doc_count": 1716
                }, 
                {
                    "key": 99, 
                    "doc_count": 190
                }, 
                {
                    "key": 4, 
                    "doc_count": 1
                }, 
                {
                    "key": 6, 
                    "doc_count": 1
                }
            ]
        }
    }
}
```

由于size设置为0，它并没有返回文档的信息，只是返回了聚合的结果。


## 参考资料
> - [Elasticsearch 数据搜索篇·【入门级干货】](http://www.cnblogs.com/xing901022/p/4967796.html)
