---
title: Es – ignore_above
toc: true
comments: true
share: true
date: 2017-08-23 10:49:39
tags:
 - Elasticsearch
 - Es
 - Ignore_above
categories:
 - Elasticsearch
---

对 not_analyzed 字符串字段默认设置，以及出现了超长的标题所致。根本原因在于标题没有一个空格，es将其当成了整个的词

查看 elasticsearch 的文档，详述如下：<!-- more -->


### ignore_above

对超过 ignore_above 的字符串，analyzer 不会进行处理；所以就不会索引起来。导致的结果就是最终搜索引擎搜索不到了。这个选项主要对 not_analyzed 字段有用，这些字段通常用来进行过滤、聚合和排序。而且这些字段都是结构化的，所以一般不会允许在这些字段中索引过长的项。


``` shell
PUT my_index
{
  "mappings": {
    "my_type": {
      "properties": {
        "message": {
          "type": "string",
          "index": "not_analyzed",
          "ignore_above": 20                ...... (1)
        }
      }
    }
  }
}

PUT my_index/my_type/1               ...... (2)
{
  "message": "Syntax error"
}

PUT my_index/my_type/2               ...... (3)
{
  "message": "Syntax error with some long stacktrace"
}

GET _search                                    ...... (4)
{
  "aggs": {
    "messages": {
      "terms": {
        "field": "message"
      }
    }
  }
}

```
(1) 这个字段忽略所有长度超过 20 的字符串
(2) 这个文档会被成功索引
(3) 这个文档会被索引，但是 message 字段却不会被索引
(4) 搜索会返回这两个问答是哪个，但是只有第一个会出现在项的聚合中

> ignore_aboe 设置允许针对统一索引中的同样名称的字段设置不同的值。可以使用 [PUT mapping API](https://www.elastic.co/guide/en/elasticsearch/reference/2.0/indices-put-mapping.html) 来更新已经存在的字段。

这个选项在保护 Lucene 的项的字节长度限制 32766 发挥作用。

> ignore_above 值表示字符个数，但是 Lucene 计算的是字节数。如果你使用包含很多非 ASCII 字符的 UTF-8 文本，你应该将这个限制设置成 32766 / 3 = 10922 因为 UTF-8 字符可能最多占用 3 个字节。
