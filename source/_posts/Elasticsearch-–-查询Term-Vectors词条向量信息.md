---
title: Es - 查询Term Vectors词条向量信息
toc: true
comments: true
share: true
description: false
date: 2017-12-21 19:58:23
tags:
 - Elasticsearch
 - Es
categories:
 - Elasticsearch
---

## 关于Term Vectors

额，对于这个专业词汇，暂且就叫做词条向量吧，因为实在想不出什么标准的翻译。说的土一点，也可以理解为关于词的一些统计信息。再说的通俗点，如果想进行全文检索，即从一个词搜索与它相关的文档，总得有个什么记录的信息吧！这就是Term Vectors。<!-- more -->

为了不干扰正常的理解，后续就都直接称呼英文的名字吧！免得误导...

先不看这篇文章，如果想要记录全文检索的信息，大家设想一下我们都需要什么内容，就拿"hello world! hello everybody!"来举例。

- 首先就是这句话都有什么词，"hello","world","everybody"
- 然后是这些词关联的文档，因为有可能不止上面这一句话。
- 最后就是词在文档中的位置，比如hello，出现了两次，就需要记录两份位置信息。

关于TermVector在Lucene中的概念，可以参考[网络中的一篇文章](http://blog.csdn.net/wangzhengnb/article/details/7782549)

## 使用_termvectors查询词条向量
在Elasticsearch中可以使用_termvectors查询一个文档中词条相关的信息。这个文档可能是es中存储的，也可能是用户直接在请求体中自定义的。这个方法默认是一个实时的统计信息。

常见的语法如：
```
curl -XGET 'http://localhost:9200/twitter/tweet/1/_termvectors?pretty=true'
```
也可以指定某个字段，返回这个字段的信息：
```
curl -XGET 'http://localhost:9200/twitter/tweet/1/_termvectors?fields=text,...'
```
注意，在Elasticsearch中2.0之前都是使用_termvector，之后都是使用的_termvectors。

## 返回的信息
使用上面的请求，会返回词条相关的信息：

- 词条的信息，比如position位置、start_offset开始的偏移值、end_offset结束的偏移值、词条的payLoads（这个主要用于自定义字段的权重）
- 词条统计，doc_freq、ttf该词出现的次数、term_freq词的频率
- 字段统计，包含sum_doc_freq该字段中词的数量(去掉重复的数目)、sum_ttf文档中词的数量（包含重复的数目）、doc_count涉及的文档数等等。
默认会返回词条的信息和统计，而不会返回字段的统计。

另外，默认这些统计信息是基于分片的，可以设置dfs为true,返回全部分片的信息，但是会有一定的性能问题，所以不推荐使用。还可以使用field字段对返回的统计信息的字段进行过滤，只返回感兴趣的那部分内容。

## 例子1：返回存储的Term Vectors信息

首先需要定义一下映射的信息：
```
curl -s -XPUT 'http://localhost:9200/twitter/' -d '{
  "mappings": {
    "tweet": {
      "properties": {
        "text": {
          "type": "string",
          "term_vector": "with_positions_offsets_payloads",
          "store" : true,
          "analyzer" : "fulltext_analyzer"
         },
         "fullname": {
          "type": "string",
          "term_vector": "with_positions_offsets_payloads",
          "analyzer" : "fulltext_analyzer"
        }
      }
    }
  },
  "settings" : {
    "index" : {
      "number_of_shards" : 1,
      "number_of_replicas" : 0
    },
    "analysis": {
      "analyzer": {
        "fulltext_analyzer": {
          "type": "custom",
          "tokenizer": "whitespace",
          "filter": [
            "lowercase",
            "type_as_payload"
          ]
        }
      }
    }
  }
}'
```
然后插入两条数据：
```
curl -XPUT 'http://localhost:9200/twitter/tweet/1?pretty=true' -d '{
  "fullname" : "John Doe",
  "text" : "twitter test test test "
}'

curl -XPUT 'http://localhost:9200/twitter/tweet/2?pretty=true' -d '{
  "fullname" : "Jane Doe",
  "text" : "Another twitter test ..."
}'
```

接下来查询一下文档1的Term Vectors信息:
```
curl -XGET 'http://localhost:9200/twitter/tweet/1/_termvectors?pretty=true' -d '{
  "fields" : ["text"],
  "offsets" : true,
  "payloads" : true,
  "positions" : true,
  "term_statistics" : true,
  "field_statistics" : true
}'
```
可以得到下面的结果：
```
{
    "_id": "1",
    "_index": "twitter",
    "_type": "tweet",
    "_version": 1,
    "found": true,
    "term_vectors": {
        "text": {
            "field_statistics": {
                "doc_count": 2,
                "sum_doc_freq": 6,
                "sum_ttf": 8
            },
            "terms": {
                "test": {
                    "doc_freq": 2,
                    "term_freq": 3,
                    "tokens": [
                        {
                            "end_offset": 12,
                            "payload": "d29yZA==",
                            "position": 1,
                            "start_offset": 8
                        },
                        {
                            "end_offset": 17,
                            "payload": "d29yZA==",
                            "position": 2,
                            "start_offset": 13
                        },
                        {
                            "end_offset": 22,
                            "payload": "d29yZA==",
                            "position": 3,
                            "start_offset": 18
                        }
                    ],
                    "ttf": 4
                },
                "twitter": {
                    "doc_freq": 2,
                    "term_freq": 1,
                    "tokens": [
                        {
                            "end_offset": 7,
                            "payload": "d29yZA==",
                            "position": 0,
                            "start_offset": 0
                        }
                    ],
                    "ttf": 2
                }
            }
        }
    }
}
```
可以看到上面返回了词条的统计信息，以及字段的统计信息。

## 例子2：轻量级生成Term Vectors
虽然这个字段不是显示存储的，但是仍然可以进行词条向量的信息统计。因为ES可以在查询的时候，从_source中分析出相应的内容。
```
curl -XGET 'http://localhost:9200/twitter/tweet/1/_termvectors?pretty=true' -d '{
  "fields" : ["text", "some_field_without_term_vectors"],
  "offsets" : true,
  "positions" : true,
  "term_statistics" : true,
  "field_statistics" : true
}'
```
关于字段的存储于不存储，可以简单的理解为：

- 如果字段存储，在ES进行相关的查询时，会直接从存储的字段读取信息
- 如果字段不存储，ES会从_source中查询分析，提取相应的部分。

由于每次读取操作都是一次的IO，因此如果你不是只针对某个字段、或者_source中的信息太多，那么请优先不存储该字段，即从_source中获取就好。

## 例子3：手动自定义的文档统计
ES支持对一个用户自定义的文档进行分析，比如：
```
curl -XGET 'http://localhost:9200/twitter/tweet/_termvectors' -d '{
  "doc" : {
    "fullname" : "John Doe",
    "text" : "twitter test test test"
  }
}'
```
注意如果这个字段没有预先定义映射，那么会按照默认的映射配置进行分析。

## 例子4：重新定义分析器
可以使用per_field_analyzer参数定义该字段的分析器，这样每个字段都可以使用不同的分析器，分析其词条向量的信息。如果这个字段已经经过存储，那么会重新生成它的词条向量，如：
```
curl -XGET 'http://localhost:9200/twitter/tweet/_termvectors' -d '{
  "doc" : {
    "fullname" : "John Doe",
    "text" : "twitter test test test"
  },
  "fields": ["fullname"],
  "per_field_analyzer" : {
    "fullname": "keyword"
  }
}'
```
会返回：
```
{
  "_index": "twitter",
  "_type": "tweet",
  "_version": 0,
  "found": true,
  "term_vectors": {
    "fullname": {
       "field_statistics": {
          "sum_doc_freq": 1,
          "doc_count": 1,
          "sum_ttf": 1
       },
       "terms": {
          "John Doe": {
             "term_freq": 1,
             "tokens": [
                {
                   "position": 0,
                   "start_offset": 0,
                   "end_offset": 8
                }
             ]
          }
       }
    }
  }
}

```

## 例子5：字段过滤器

在进行词条向量的信息查询时，可以根据自定义的过滤器，返回感兴趣的信息。

常用的过滤器参数如：

- max_num_terms 最大的词条数目
- min_term_freq 最小的词频，比如忽略那些在字段中出现次数小于一定值的词条。
- max_term_freq 最大的词频
- min_doc_freq 最小的文档频率，比如忽略那些在文档中出现次数小于一定的值的词条
- max_doc_freq 最大的文档频率
- min_word_length 忽略的词的最小长度
- max_word_length 忽略的词的最大长度
```
GET /imdb/movies/_termvectors
{
    "doc": {
      "plot": "When wealthy industrialist Tony Stark is forced to build an armored suit after a life-threatening incident, he ultimately decides to use its technology to fight against evil."
    },
    "term_statistics" : true,
    "field_statistics" : true,
    "dfs": true,
    "positions": false,
    "offsets": false,
    "filter" : {
      "max_num_terms" : 3,
      "min_term_freq" : 1,
      "min_doc_freq" : 1
    }
}
```
会返回：
```
{
   "_index": "imdb",
   "_type": "movies",
   "_version": 0,
   "found": true,
   "term_vectors": {
      "plot": {
         "field_statistics": {
            "sum_doc_freq": 3384269,
            "doc_count": 176214,
            "sum_ttf": 3753460
         },
         "terms": {
            "armored": {
               "doc_freq": 27,
               "ttf": 27,
               "term_freq": 1,
               "score": 9.74725
            },
            "industrialist": {
               "doc_freq": 88,
               "ttf": 88,
               "term_freq": 1,
               "score": 8.590818
            },
            "stark": {
               "doc_freq": 44,
               "ttf": 47,
               "term_freq": 1,
               "score": 9.272792
            }
         }
      }
   }
}
```




## 参考资料
> - [在Elasticsearch中查询Term Vectors词条向量信息](http://www.cnblogs.com/xing901022/p/5348737.html)

