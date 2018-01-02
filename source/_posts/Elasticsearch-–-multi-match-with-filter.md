---
title: Es - multi-match with filter
toc: true
comments: true
share: true
description: false
date: 2017-11-23 13:52:47
tags:
 - Elasticsearch
 - Es
 - Filter
 - Multi match
categories:
 - Elasticsearch
---
<style>.posts-expand .post-body img {padding: 0px;border: 0px solid #ddd;}</style>


Depending on what you need you have to put the filter in the proper position. You have two options:

Use a top-level filter and apply the filter only to the search results but not to the facets

```json
{
    "query" : {
        "multi_match" {
            "query" : "this is a test",
            "fields" : [ "subject^2", "message" ]
        }
    },
    "filter" : {
        "term" : {"username":"slimkicker"}
    }
} 
```
<!-- more -->

Use a filtered query and apply the filter to both the search results and the facets
```json
{
    "query" :{
        "filtered" : {
            "query" : {
                "multi_match" : {
                    "query" : "this is a test",
                    "fields" : [ "subject^2", "message" ]
                }
            },
            "filter" : {
                "term" : {"username":"slimkicker"}
            }
        }
    }
}
```

With Elasticsearch 5 the syntax has changed to the usage of bool query, e.g.

```json
{
  "from" : 0,
  "size" : 10,
  "sort" : "publishDate",
  "query": {
    "bool": {  
      "must" : {
        "multi_match" : {
          "query":      "wedding",
          "type":       "most_fields",
          "fields":     [ "title", "text" ]
        }
      },
      "filter": {
        "term": {
          "locale": "english"
        }
      }
    }
  }
}
```
Documentation can be found [here](https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl-filtered-query.html).



## 参考资料
> - [ElasticSearch, multi-match with filter?](https://stackoverflow.com/questions/16776260/elasticsearch-multi-match-with-filter)

