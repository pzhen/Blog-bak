---
title: Es - 重要词项聚合
toc: true
comments: true
share: true
date: 2017-11-03 15:13:27
tags:
 - Elasticsearch
 - Es
 - 聚合
categories:
 - Elasticsearch
---

### 词项聚合

significant_terms 聚合，可以用于全文检索字段，但是要注意，非常消耗内存，因为需要将所有词项加载到内存中，下面是语句。<!-- more -->

```
curl XGET 'http://127.0.0.1:9200/comic/comic/_search?size=0&pretty ' -d '{
  "query": {
    "term": {
    	"status": "2"
    }
  },
  "aggregations": {
    "description": {
      "significant_terms": {
        "field": "name"
      }
    }
  }
}'
```

### 后台数据集过滤

```
curl XGET 'http://127.0.0.1:9200/comic/comic/_search?size=0&pretty ' -d '{
  "query": {
    "match": {
    	"intern": "Richard"
    }
  },
  "aggregations": {
    "description": {
      "significant_terms": {
        "field": "grade",
        "background_filter":{
        	"term":{
        		"type":"grade"
        	}
        }
      }
    }
  }
}'
```

简单说下使用限制问题

* 内存消耗

* 不应该作为顶级聚合使用，例如:match_all 因为此时前台数据集后台数据集数据完全一样，所以无法感知词项在两者中的频率差异。

* 计数是近似值

* 不能使用浮点数字段






