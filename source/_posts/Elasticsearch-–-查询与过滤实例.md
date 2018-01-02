---
title: Es – 查询与过滤实例
toc: true
comments: true
share: true
date: 2017-09-06 15:12:40
tags:
 - Elasticsearch
 - Es
 - filter
categories:
 - Elasticsearch
---

之前说过score字段指定了文档的分数，使用查询会计算文档的分数，最后通过分数确定哪些文档更相关，返回哪些文档。

有的时候我们可能对分数不感兴趣，就可以使用filter进行过滤，它不会去计算分值，因此效率也就更高一些。

filter过滤可以嵌套在bool查询内部使用，比如想要查询在2000-3000范围内的所有文档，可以执行下面的命令：<!-- more -->

```
curl -XPOST 'localhost:9200/bank/_search?pretty' -d '
{
  "query": {
    "bool": {
      "must": { "match_all": {} },
      "filter": {
        "range": {
          "balance": {
            "gte": 20000,
            "lte": 30000
          }
        }
      }
    }
  }
}'
```



 - post_filter(先查询再过滤)
 ```
 { 
     "query": {
         "match":{"title":"Catch-22"}
     },
     "post_filter":{
         "term":{"year":1961}
     }
 }
 ```
 - filtered(先过滤再查询，速度快)
 ```
 {
     "query": {
         "filtered": {
             "query": {
                 "match": {
                     "title": "Catch-22"
                 }
             }, 
             "filter": {
                 "term": {
                     "year": 1961
                 }
             }
         }
     }
 }
 ```
 
以上这种方式在2.2版本被废弃调用，[改用bool的方式](https://www.elastic.co/guide/en/elasticsearch/reference/2.2/breaking_20_query_dsl_changes.html#_literal_filtered_literal_query_and_literal_query_literal_filter_deprecated)
```
{
    "query": {
        "bool": {
            "must": {
                "match": {
                    "title": "Catch-22"
                }
            }, 
            "filter": {
                "term": {
                    "year": 1961
                }
            }
        }
    }
}
```

### 1.例子：

1.title : 字段包含xxxx,
2.content: 字段包含xxxx,
3.status: 字段必须是published
4.publish_date 从2015年01月01日之后

```
{
  "query":{
    "bool":{
      "must":[
        {"match":{"title":"xxxx"}},
        {"match":{"content":"xxxx"}},
      ],
      "filter":[
        {"term":{"status":"published"}},
        {"range":{"publish_date":{"gte":"2015-01-01"}}}
      ]
    }
  }
}
```

### 2.实例

```
{
  "query": {
    "bool": {
      "filter": [
        {
          "term": {
            "vmh_uid": "11111111"
          }
        },
        {
          "term": {
            "sina_user_id": "1111111111"
          }
        },
        {
          "term": {
            "comic_id": "111"
          }
        },
        {
          "term": {
            "chapter_id": "11111"
          }
        },
        {
          "term": {
            "image_no": "1"
          }
        },
        {
          "term": {
            "source": "pc"
          }
        },
        {
          "term": {
            "create_time": "1418114831"
          }
        }
      ]
    }
  }
}

```
采用php-client：

```php
public function es_search(){

        $hosts = [
            #'127.0.0.1:9200',
            #'127.0.0.1:9201',
            #'127.0.0.1:9202',
            '127.0.0.1:9200',
        ];
        $client = ClientBuilder::create()->setHosts($hosts)->build();


        $params = array(
            'index' => "comic_readlog",
            'type' => "comic_readlog",
            'body' => array(
                'query' => array(
                    'bool' => array(
                        "filter" => array(
                            "term" => array("vmh_uid" => "xxx"),
                            "term" => array("sina_user_id"=> "xxxxx"),
                            "term" => array("comic_id"=> "xxxxx"),
                            "term" => array("chapter_id"=> "xxx"),
                            "term" => array("image_no"=> "xxx"),
                            "term" => array("create_time"=> "xxxxx"),
                        )
                    )
                ),
            ),
        );

        $res = $client->search($params);
        print_r($res);

    }
```

