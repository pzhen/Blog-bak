---
title: Es - 处理 Null 值
toc: true
comments: true
share: true
date: 2017-10-26 16:40:51
tags:
 - Elasticsearch
 - Es
categories:
 - Elasticsearch
---

开始设计项目Es模块的时候要考虑好对空值的处理，不然就会出现我之前出现的问题。
<!-- more -->

## 处理Null值：

回想在之前例子中，有的文档有名为 tags （标签）的字段，它是个多值字段， 一个文档可能有一个或多个标签，也可能根本就没有标签。如果一个字段没有值，那么如何将它存入倒排索引中的呢？

这是个有欺骗性的问题，因为答案是：什么都不存。让我们看看之前内容里提到过的倒排索引：


| Token        | DocIDs           |
| ------------- |:-------------:|
| open_source      | 2 |
| search      | 1,2      |


如何将某个不存在的字段存储在这个数据结构中呢？无法做到！简单的说，一个倒排索引只是一个 token 列表和与之相关的文档信息，如果字段不存在，那么它也不会持有任何 token，也就无法在倒排索引结构中表现。

最终，这也就意味着 ，null, [] （空数组）和 [null] 所有这些都是等价的，它们无法存于倒排索引中。

显然，世界并不简单，数据往往会有缺失字段，或有显式的空值或空数组。为了应对这些状况，Elasticsearch 提供了一些工具来处理空或缺失值。

### exists Filter

第一件武器就是 exists 存在查询。 这个查询会返回那些在指定字段有任何值的文档，让我们索引一些示例文档并用标签的例子来说明：

```
POST /my_index/posts/_bulk
{ "index": { "_id": "1" }}
{ "tags" : ["search"] }                     ...(1)
{ "index": { "_id": "2" }}
{ "tags" : ["search", "open_source"] }      ...(2)
{ "index": { "_id": "3" }}
{ "other_field" : "some data" }             ...(3)
{ "index": { "_id": "4" }}
{ "tags" : null }                           ...(4)
{ "index": { "_id": "5" }}
{ "tags" : ["search", null] }               ...(5)

```

(1) tags 字段有一个值
(2) tags 字段有两个值
(3) tags 字段丢失
(4) tags 字段设置为 null
(5) tag 字段有一个值和一个 null

最终的倒排索引就是：

| Token        | DocIDs           |
| ------------- |:-------------:|
| open_source      | 2 |
| search      | 1,2,5      |

我们的目标是找到那些被设置过标签字段的文档，并不关心标签的具体内容。只要它存在于文档中即可，用 SQL 的话就是用 IS NOT NULL 非空进行查询：

```
SELECT tags
FROM posts
WHERE tags IS NOT NULL
```

在 Elasticsearch 中，使用 exists 查询的方式如下：

```
GET /my_index/posts/_search
{
    "query" : {
        "constant_score" : {
            "filter" : {
                "exists" : { "field" : "tags" }
            }
        }
    }
}
```

最后返回三个文档：

```
"hits" : [
    {
      "_id" :     "1",
      "_score" :  1.0,
      "_source" : { "tags" : ["search"] }
    },
    {
      "_id" :     "5",
      "_score" :  1.0,
      "_source" : { "tags" : ["search", null] } 
    },
    {
      "_id" :     "2",
      "_score" :  1.0,
      "_source" : { "tags" : ["search", "open source"] }
    }
]

```

(1) 尽管文档 5 有 null 值，但它仍会被命中返回。字段之所以存在，是因为标签有实际值（ search ）可以被索引，所以 null 对过滤不会产生任何影响。

显而易见，只要 tags 字段存在项（term）的文档都会命中并作为结果返回，只有 3 和 4 两个文档被排除。

### missing 过滤器

missing 过滤器本质上是 exists 的逆：它返回对应一个特定的字段没有任何值的文档，就像 SQL：

```
SELECT tags
FROM posts
WHERE tags IS NULL
```

让我们用 missing 来替换上面例子中 exists 过滤器：

```
GET /my_index/posts/_search
{
    "query" : {
        "filtered" : {
            "filter": {
                "missing" : { "field" : "tags" }
            }
        }
    }
}
```

正如你所期望的，我们拿到了在 tags 字段上没有真实值的文档——文档 3 和 4：

```
"hits" : [
    {
      "_id" :     "3",
      "_score" :  1.0,
      "_source" : { "other_field" : "some data" }
    },
    {
      "_id" :     "4",
      "_score" :  1.0,
      "_source" : { "tags" : null }
    }
]
```

> 当 null 的意思是 null
有时候我们需要区分一个字段是没有值，还是它已被显式的设置成了 null 。在之前例子中，我们看到的默认的行为是无法做到这点的；数据被丢失了。不过幸运的是，我们可以选择将显式的 null 值替换成我们指定 占位符（placeholder） 。

>在为字符串（string）、数字（numeric）、布尔值（Boolean）或日期（date）字段指定映射时，同样可以为之设置 null_value 空值，用以处理显式 null 值的情况。不过即使如此，还是会将一个没有值的字段从倒排索引中排除。

>当选择合适的 null_value 空值的时候，需要保证以下几点：
 - 它会匹配字段的类型，我们不能为一个 date 日期字段设置字符串类型的 null_value 。
 - 它必须与普通值不一样，这可以避免把实际值当成 null 空的情况。

### 对象上存在与缺失exists/missing on Objects

不仅可以过滤核心类型， exists and missing 查询 还可以处理一个对象的内部字段。以下面文档为例：

```
{
   "name" : {
      "first" : "John",
      "last" :  "Smith"
   }
}
```

我们不仅可以检查 name.first 和 name.last 的存在性，也可以检查 name ，不过在 映射 中，如上对象的内部是个扁平的字段与值（field-value）的简单键值结构，类似下面这样：

```
{
   "name.first" : "John",
   "name.last"  : "Smith"
}
```

那么我们如何用 exists 或 missing 查询 name 字段呢？ name 字段并不真实存在于倒排索引中。

原因是当我们执行下面这个过滤的时候：

```
{ "exists" : { "field" : "name" }}
```

实际上是按照：
```
{
    "bool": {
        "should": [
            { "exists": { "field": { "name.first" }}},
            { "exists": { "field": { "name.last"  }}}
        ]
    }
}
```

这也就意味着，如果 first 和 last 都是空，那么 name 这个命名空间才会被认为不存在。



## 参考资料
> - [处理 Null 值](https://www.elastic.co/guide/cn/elasticsearch/guide/current/_dealing_with_null_values.html)

