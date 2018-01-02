---
title: Es – 二次打分处理方案
toc: true
comments: true
share: true
description: false
date: 2017-12-21 20:51:32
tags:
 - Es
 - Elasticsearch
categories:
 - Elasticsearch
---

有时ES默认的评分规则并不能满足需求，时长会有在old_source的基础上根据某字段的值需要重新打分的需求场景，比如在相关度相差不大的情况下时间越进越靠前，或者评论数越多越靠前等等。此时需要重新打分。对此可以通过两种方式法来处理：<!-- more -->

1、在创建索引的时候提高文档的权重，根据因素字段值来给文档设置boost.这种方式在lucene之前有效，之后就无效了。不建议采用。

2、通过function_query来设置分数。

## 通过function_query来设置分数
### 线性提升

如在相关度相差不大的情况下，投票的数量越多排名越往前。可以采用简单的线性方式来处理:
```
GET /blogposts/post/_search  
{  
  "query": {  
    "function_score": {  
      "query": {  
        "multi_match": {  
          "query":    "popularity",  
          "fields": [ "title", "content" ]  
        }  
      },  
      "field_value_factor": {  
        "field":    "votes",  
        "modifier": "log1p",  
        "factor":   2   
      }  
    }  
  }  
}  
```

其中：
- field：表示影响权重的字段例子中是votes
- modifier：表示影响的规则
- 修饰语 modifier 的值可以为：
                 none （默认状态）
log 、 log1p 、 log2p 、 ln 、 ln1p 、 ln2p 、 square 、 sqrt 以及 reciprocal。
facror：表示影响因子。
通过上面设置后整个打分变为：

```
new_score = old_score * log(1 + factor * number_of_votes)  
factor 值大于 1 会提升效果， factor 值小于 1 会降低效果。  
```

 初次之外还可以设置boost_mode影响因子和old_source通过什么运算来得出新分值。

```
GET /blogposts/post/_search  
{  
  "query": {  
    "function_score": {  
      "query": {  
        "multi_match": {  
          "query":    "popularity",  
          "fields": [ "title", "content" ]  
       }  
      },  
      "field_value_factor": {  
        "field":    "votes",  
        "modifier": "log1p",  
        "factor":   0.1  
      },  
      "boost_mode": "sum" ,  
      "max_boost":  1.5   
    }  
  }  
}  
```

boost_mode
multiply评分 _score 与函数值的积（默认）
sum评分 _score 与函数值的和
min评分 _score 与函数值间的较小值
max评分 _score 与函数值间的较大值
replace函数值替代评分 _scoremax_boost设置最大的得分分值
 无论 field_value_factor 函数的结果如何，最终结果都不会大于 1.5 

### 引入模型函数来控制二次评分

上线是一种线性的影响关系，有时会有范围性质、分数变化缓慢的需求场景，此时在使用上面的方案未免为使分数变化的不太圆滑，es提供了三种衰减函数(decay functions)来计算分数，让我们有能力在两个滑动标准如：地点和价格，时间等之间权衡。

       linear、 exp 和 gauss （线性、指数和高斯函数），它们可以操作数值、时间以及经纬度地理坐标点这样的字段。所有三个函数都能接受以下参数：

origin:中心点 或字段可能的最佳值，落在原点 origin 上的文档评分 _score 为满分 1.0 。
scale:衰减率,即一个文档从原点origin下落时,评分_score 改变的速度.(例如，每 £10 欧元或每 100 米)
decay:从原点 origin 衰减到 scale 所得的评分 _score ，默认值为 0.5 。
offset:以原点 origin 为中心点，为其设置一个非零的偏移量 offset 覆盖一个范围，而不只是单个原点。在范围 -offset <= origin <= +offset 内的所有评分 _score 都是 1.0 。
这三个函数的唯一区别就是它们衰减曲线的形状，用图来说明会更为直观

![](http://static.golangtab.com/images/2017-11/20170601162808488.png)

图 [图 33 “衰减函数曲线”](https://www.elastic.co/guide/cn/elasticsearch/guide/current/decay-functions.html#img-decay-functions) 中所有曲线的原点 origin （即中心点）的值都是 40 ， offset 是 5 ，也就是在范围 40 - 5 <= value <= 40 + 5 内的所有值都会被当作原点 origin 处理——所有这些点的评分都是满分 1.0 。

在此范围之外，评分开始衰减，衰减率由 scale 值（此例中的值为 5 ）和 衰减值 decay （此例中为默认值 0.5 ）共同决定。结果是所有三个曲线在 origin +/- (offset + scale) 处的评分都是 0.5 ，即点 30和 50 处。

linear 、 exp 和 gauss （线性、指数和高斯）函数三者之间的区别在于范围（ origin +/- (offset + scale) ）之外的曲线形状：

linear 线性函数是条直线，一旦直线与横轴 0 相交，所有其他值的评分都是 0.0 。
exp 指数函数是先剧烈衰减然后变缓。
gauss 高斯函数是钟形的——它的衰减速率是先缓慢，然后变快，最后又放缓。
选择曲线的依据完全由期望评分 _score 的衰减速率来决定，即距原点 origin 的值。

回到我们的例子：用户希望租一个离伦敦市中心近（ { "lat": 51.50, "lon": 0.12} ）且每晚不超过 £100 英镑的度假屋，而且与距离相比， 我们的用户对价格更为敏感，这样查询可以写成：

```
{  
    "query": {  
        "function_score": {  
          "functions": [  
            {  
              "gauss": {  
                "price": {  
                  "origin": "0",  
                  "scale": "20"  
                }  
              }  
            },  
            {  
              "gauss": {  
                "location": {  
                  "origin": "11, 12",  
                  "scale": "2km"  
                }  
              }  
            }  
          ],  
          "query": {  
            "match": {  
              "properties": "balcony"  
            }  
          },  
          "score_mode": "multiply"  
        }  
    }  
}  
```

location 字段以地理坐标点 geo_point 映射。
price 字段是数值。
price 语句是 location 语句权重的两倍。
location 语句可以简单理解为：
以伦敦市中作为原点 origin 。
所有距原点 origin 2km 范围内的位置的评分是 1.0 。
距中心 5km （ offset + scale ）的位置的评分是 0.5 。

weight 参数可以被用来调整每个语句的贡献度，权重 weight 的默认值是 1.0 。这个值会先与每个句子的评分相乘，然后再通过 score_mode 的设置方式合并。



## 参考资料
> - [解析elasticsearch二次打分处理方案](http://blog.csdn.net/liyantianmin/article/details/72832561)

