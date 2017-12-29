---
title: Es – Ik 分词器
toc: true
date: 2017-07-20 16:24:42
tags:
 - Elasticsearch
 - Es
 - Ik 
categories:
 - Elasticsearch
share: true
---

#### 下载ik分词器包
```
https://github.com/medcl/elasticsearch-analysis-ik
```
#### 解压
```
unzip elasticsearch-analysis-ik-master.zip
```
#### 打包
```
cd elasticsearch-analysis-ik-master

mvn package
```

打包后的文件在elasticsearch-analysis-ik-master/target/目录下

#### 集成到ES

在elasticsearch-5.3.0/plugins下创建目录 ik
```
copy and unzip target/releases/elasticsearch-analysis-ik-5.3.0.zip to your-es-root/plugins/ik
```
然后删除 zip文件
```
rm -f elasticsearch-analysis-ik-5.3.0.zip
```
#### 重启ES
```
./bin/elasticsearch
```
#### 添加数据测试

##### 创建索引
```
curl -XPUT http://localhost:9200/user 
```

##### 创建mapping
```
curl -XPOST http://localhost:9200/user/fulltext/_mapping -d'
{
    "fulltext": {
             "_all": {
            "analyzer": "ik_max_word",
            "search_analyzer": "ik_max_word",
            "term_vector": "no",
            "store": "false"
        },
        "properties": {
            "content": {
                "type": "text",
                "analyzer": "ik_max_word",
                "search_analyzer": "ik_max_word",
                "include_in_all": "true",
                "boost": 8
            }
        }
    }
}'
```
我的理解就是solr中的分词器 的 fieldType。

#### 添加文档

```
curl -XPOST http://localhost:9200/user/fulltext/1 -d'
{"content":"美国留给伊拉克的是个烂摊子吗"}
'
curl -XPOST http://localhost:9200/user/fulltext/2 -d'
{"content":"公安部：各地校车将享最高路权"}
'
curl -XPOST http://localhost:9200/user/fulltext/3 -d'
{"content":"中韩渔警冲突调查：韩警平均每天扣1艘中国渔船"}
'
curl -XPOST http://localhost:9200/user/fulltext/4 -d'
{"content":"中国驻洛杉矶领事馆遭亚裔男子枪击 嫌犯已自首"}
'
```

#### 测试
```
curl -XPOST http://localhost:9200/user/fulltext/_search?pretty  -d'
{
    "query" : { "match" : { "content" : "中国" }},
    "highlight" : {
        "pre_tags" : ["<tag1>", "<tag2>"],
        "post_tags" : ["</tag1>", "</tag2>"],
        "fields" : {
            "content" : {}
        }
    }
}
'
结果集
{
  "took" : 7,
  "timed_out" : false,
  "_shards" : {
    "total" : 5,
    "successful" : 5,
    "failed" : 0
  },
  "hits" : {
    "total" : 2,
    "max_score" : 4.278213,
    "hits" : [
      {
        "_index" : "user",
        "_type" : "fulltext",
        "_id" : "4",
        "_score" : 4.278213,
        "_source" : {
          "content" : "中国驻洛杉矶领事馆遭亚裔男子枪击 嫌犯已自首"
        },
        "highlight" : {
          "content" : [
            "<tag1>中国</tag1>驻洛杉矶领事馆遭亚裔男子枪击 嫌犯已自首"
          ]
        }
      },
      {
        "_index" : "user",
        "_type" : "fulltext",
        "_id" : "3",
        "_score" : 2.2110996,
        "_source" : {
          "content" : "中韩渔警冲突调查：韩警平均每天扣1艘中国渔船"
        },
        "highlight" : {
          "content" : [
            "中韩渔警冲突调查：韩警平均每天扣1艘<tag1>中国</tag1>渔船"
          ]
        }
      }
    ]
  }
}
```
也可以直接测试不需要测试数据。
```
curl -XGET 'http://localhost:9200/_analyze?pretty&analyzer=ik_max_word' -d '联想是全球最大的笔记本厂商'
```