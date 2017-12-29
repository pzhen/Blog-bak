---
title: Es - 自动补全/联想
toc: true
comments: true
share: true
description: false
date: 2017-12-01 15:43:39
tags:
 - Elasticsearch
 - Es
categories:
 - Elasticsearch
---

搜索引擎的自动补全，本文基于搜索历史进行补全，适用于拥有大量数据的搜索引擎。在ElasticSearch中可以使用Completion Suggester实现。

首先创建基于ik插件的自动补全mapping：
```
curl -XPOST http://localhost:9200/website/suggest/_mapping -d'
{
  "suggest": {
    "properties": {
      "tag": {
        "type": "string",
        "analyzer": "ik",
        "search_analyzer": "ik"
      },
      "tag_suggest": {
        "type": "completion",
        "analyzer": "ik",
        "search_analyzer": "ik",
        "payloads": false
      }
    }
  }
}'
```

插入测试数据：
```
curl -XPUT "http://localhost:9200/website/suggest/3" -d'{
    "tag":["梭织","蕾丝","汗布","针织","毛呢"],
    "tag_suggest":{
        "input":["梭织","蕾丝","汗布","针织","毛呢"]
    }
}'
```
```
curl -XPUT "http://localhost:9200/website/suggest/4" -d'{
    "tag":["绒布","牛仔布","罗纹","网眼","平板布"],
    "tag_suggest":{
        "input":["绒布","牛仔布","罗纹","网眼","平板布"]
    }
}'
```
```
curl -XPUT "http://localhost:9200/website/suggest/4" -d'{
    "tag":["蕾丝布","蕾丝网"],
    "tag_suggest":{
        "input":["蕾丝布","蕾丝网"]
    }
}'
```
最后通过_suggest对[Completion Suggester](https://www.elastic.co/guide/en/elasticsearch/reference/current/search-suggesters-completion.html)数据进行搜索:
```
curl -XPOST "http://localhost:9200/website/_suggest" -d'
{
    "suggest-suggest": {
    "text": "蕾丝",
    "completion": {
      "field": "tag_suggest",
      "size": 10 //返回结果数量
      }
    }
}'
```

其中suggest-suggest中第一个suggest代表当前索引文档的type，^_^，比较懒，不想改type名了。

如果结果返回：
```
{
  "_shards": {
    "total": 5,
    "successful": 5,
    "failed": 0
  },
  "suggest_suggest": [
    {
      "text": "蕾丝",
      "offset": 0,
      "length": 2,
      "options": [
        {
          "text": "蕾丝",
          "score": 1
        },
        {
          "text": "蕾丝布",
          "score": 1
        },
        {
          "text": "蕾丝网",
          "score": 1
        }
      ]
    }
  ]
}
```
恭喜你，自动补全功能即已实现。

## 参考资料
> - [Quick and Dirty Autocomplete with Elasticsearch Completion Suggest](https://qbox.io/blog/quick-and-dirty-autocomplete-with-elasticsearch-completion-suggest)