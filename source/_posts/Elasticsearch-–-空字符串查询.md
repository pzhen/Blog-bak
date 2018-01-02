---
title: Es – 空字符串查询
toc: true
comments: true
share: true
date: 2017-10-17 14:40:45
tags:
 - Elasticsearch
 - Es
categories:
 - Elasticsearch
---

今天遇到了在Es中查询空字符串的问题，查了好久没有别的好的方式，有人说可以将mapping映射修改成keyword分词方式，我的不能改，所以没有测试。

我采用根据字段内容的长度来过滤。<!-- more -->

启用script查询吧。

elasticsearch.yml 配置文件开启Script,否则异常。

```
script.inline: true
script.indexed: true
```

下面是我的查询语句。

```
{
  "query": {
    "filtered": {
      "filter": {
        "script": {
          "script": "doc['sina_nickname'].size() < 1"
        }
      }
    }
  }
}
```




## 参考资料
> - [elasticsearch依据字段长度过滤](http://blog.csdn.net/u012307002/article/details/51281434)
