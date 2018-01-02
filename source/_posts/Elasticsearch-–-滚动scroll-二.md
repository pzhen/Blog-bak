---
title: Es – 滚动scroll(二)
toc: true
comments: true
share: true
date: 2017-09-12 15:27:42
tags:
 - Elasticsearch
 - Scroll
 - From 
 - Size
categories:
 - Elasticsearch
---

scroll 今天用到了记录下。没有采用from size原因网上一堆，上篇博客也有说，不在重复。 

将漫画的名字生成一份词库，打印出名字然后流定向文件就可以了。<!-- more -->

```php
public function createDicByComicName()
{
    $expireTime = "1m";

    $query = json_encode(array(
        "sort" => array(
            "comic_id" => array("order" => "asc")
        ),
        "size" => "10"
    ));

    $res = $this->elasticsearch->masterEs(self::Es_Mappings_Index_Comic)->elastic_query(self::Es_Mappings_Index_Comic."/_search/?scroll={$expireTime}", $method = 'POST', $query);

    $listPageOneData = $res["hits"]["hits"];

    if (!empty($listPageOneData))
    {
        foreach ($listPageOneData as $key => $value)
        {
            echo $value["_source"]["name"]."\n";
        }

        $listScrollid = array($res["_scroll_id"]);

        while (true)
        {
            if (empty($listScrollid))
            {
                break;
            }

            $query = json_encode(array(
                "scroll" => $expireTime,
                "scroll_id" => array_pop($listScrollid)
            ));

            $res = $this->elasticsearch->masterEs(self::Es_Mappings_Index_Comic)->query_by_scroll_id($query);

            $listPageOneData = $res["hits"]["hits"];

            if (!empty($listPageOneData))
            {
                array_push($listScrollid, $res["_scroll_id"]);

                foreach ($listPageOneData as $key => $value)
                {
                    echo $value["_source"]["name"]."\n";
                }

            }
            else
            {
                $listScrollid = array();
            }
        }

    }

}
```

