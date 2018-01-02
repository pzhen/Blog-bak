---
title: Es -《Elasticsearch服务器开发(第2版)》
toc: true
comments: true
share: true
date: 2017-10-25 15:37:49
tags:
 - Elasticsearch
 - Es
categories:
 - Elasticsearch
---

这里再看一下基础的知识做一个简单汇总。根据《Elasticsearch服务器开发(第2版)》<!-- more -->


## 2.1.2 创建索引 

### 创建索引:
```
curl -XPUT http://localhost:9200/blog/
```
### 关闭自动创建索引:
```
action.auto_create_index: false
```
### 删除索引：
```
curl –XDELETE http://localhost:9200/posts
```

## 2.2.1 类型确定机制

### 文本检测:

有时数据源 会省略掉数据类型的相关信息，一切都以字符串的形式呈现。解决方案是在映射定义文件中把 numeric_detection属性设置为true，以开启更积极的文本检测。

```
curl -XPUT http://localhost:9200/blog/?pretty -d '{
  "mappings" : {
    "article": {
      "numeric_detection" : true
} }
}'
```
### 布尔类型:

可惜，如果我们想要猜中布尔类型，问题仍然存在。

根据布尔类型聚合：

```
POST my_index/my_type/1
{
  "is_published": true
}

POST my_index/my_type/2
{
  "is_published": false
}

POST my_index/my_type/3
{
  "is_published": false
}

POST my_index/my_type/4
{
  "is_published": true
}

GET my_index/_search
{
  "aggs": {
    "publish_state": {
      "terms": {
        "field": "is_published"
      }
    }
  },
  "script_fields": {
    "is_published": {
      "script": "doc['is_published'].value"
    }
  }
}
```

结果：

```
{
    "took": 2,
    "timed_out": false,
    "_shards": {
        "total": 5,
        "successful": 5,
        "failed": 0
    },
    "hits": {
        "total": 4,
        "max_score": 1,
        "hits": [
            {
                "_index": "my_index",
                "_type": "my_type",
                "_id": "2",
                "_score": 1,
                "fields": {
                    "is_published": [
                        0
                    ]
                }
            },
            {
                "_index": "my_index",
                "_type": "my_type",
                "_id": "4",
                "_score": 1,
                "fields": {
                    "is_published": [
                        1
                    ]
                }
            },
            {
                "_index": "my_index",
                "_type": "my_type",
                "_id": "1",
                "_score": 1,
                "fields": {
                    "is_published": [
                        1
                    ]
                }
            },
            {
                "_index": "my_index",
                "_type": "my_type",
                "_id": "3",
                "_score": 1,
                "fields": {
                    "is_published": [
                        0
                    ]
                }
            }
        ]
    },
    "aggregations": {
        "publish_state": {
            "doc_count_error_upper_bound": 0,
            "sum_other_doc_count": 0,
            "buckets": [
                {
                    "key": 0,
                    "key_as_string": "false",
                    "doc_count": 2
                },
                {
                    "key": 1,
                    "key_as_string": "true",
                    "doc_count": 2
                }
            ]
        }
    }
}
```

### 禁用字段类型猜测:


要关闭自动添加字段，可以把dynamic属性设置为false。把dynamic属性添加为类型的属 性。例如，要在blog索引中为article类型关闭自动字段类型猜测，命令如下所示:

```
curl -XPUT 'http://localhost:9200/blog/' -d '
{
	"mappings" : {
        "article" : {
          "dynamic" : "false",
          "properties" : {
            	"id" : { "type" : "string" },
            	"content" : { "type" : "string" },
            	"author" : { "type" : "string" }
				}
			}
	} 
}'

```
## 2.2.2 索引结构映射

### 3. 核心类型

string:字符串;
number:数字;
date:日期;
boolean:布尔型;
binary:二进制。

#### (1) 公共属性

- index: analyzed / not_analyzed  是否分析

- store: true / false 是否存储

- boost: 默认值是1,boost的值 越高，字段中值的重要性也越高。字段的权重

- null_value:如果该字段并非索引文档的一部分，此属性指定应写入索引的值。默认的 行为是忽略该字段。说白了就是字段缺失值时候，显示的处理。比如null，方便后面的数据过滤

- include_in_all:此属性指定该字段是否应包括在_all字段中, false / true


待续...



