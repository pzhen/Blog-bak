---
title: Es – 查询(terms和term)
toc: true
comments: true
share: true
date: 2017-08-23 16:34:35
tags:
 - Elasticsearch
 - Es
 - Terms
 - Term
categories:
 - Elasticsearch
---

term仅匹配在给定的字段包含某个词项的文档，如<!-- more -->

```
{“query”:{“term”:{“title”:“crime”}}}
```
该查询仅匹配在title字段上包含crime的文档
terms允许在给定的字段上包含某些词项的文档，如
```
{“query”:{“term”:{“title”:[“crime”,"book"],"minimum_match:1}}}
```
该查询返回在title字段上包含一个或两个被搜索词项的所有文档