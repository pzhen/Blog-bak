---
title: Es – 修改Mappings
toc: true
comments: true
share: true
date: 2017-09-11 18:13:04
tags:
 - Es
 - Elasticsearch
 - Mappings
categories:
 - Elasticsearch
---

Es 一旦索引建立 ， Mappings 是不允许修改字段的属性的，因为修改属性这说明要重新构建索引<!-- more -->

但是添加字段是免费的。<!-- more -->

```php
$mappings = array(
            "properties" => array(
                "user_status" => array(
                    "include_in_all" => false,
                    "store" => true,
                    "type"  => "integer",
                    'index' => 'not_analyzed'
                ),
                "user_nickname" => array(
                    "type"=> "string",
                    "index" => "analyzed",
                    "analyzer"=> "ik_smart",
                    "search_analyzer"=> "ik_smart",
                    "include_in_all"=> true,
                    "term_vector"=>"with_positions_offsets",
                    'store'=> true
                ),
            )
        );

$r = $this->elasticsearch->masterEs(xxxxx)->modifyMap(xxxxxx,$mappings);

PUT index/_mapping/type  
{
data.....
}
```






