---
title: Shell - jq命令行工具
toc: true
comments: true
share: true
description: false
date: 2017-12-25 11:08:09
tags:
 - Shell
 - jq
categories:
 - Shell
---

JSON是前端编程经常用到的格式，对于PHP或者Python，解析JSON都不是什么大事，尤其是PHP的json_encode和json_decode,干的相当的漂亮。Linux下也有处理处理JSON的神器：jq。

对于JSON格式而言，jq就像sed/awk/grep这些神器一样的方便，而也，jq没有乱七八糟的依赖，只需要一个binary文件jq，就足矣。下面我们看下jq的使用。

## 1.格式化JSON

```shell
manu@manu:~/code/php/json$ cat json_raw.txt 
{"name":"Google","location":{"street":"1600 Amphitheatre Parkway","city":"Mountain View","state":"California","country":"US"},"employees":[{"name":"Michael","division":"Engineering"},{"name":"Laura","division":"HR"},{"name":"Elise","division":"Marketing"}]}
```

上面的JSON是PHP json_encode之后，echo出来的字符串，很明显，可读性太差。前一阵子写文档，需要将前后段JSON写入文档，我当时是用是网上的JSON格式化工具做的。事实上，jq就可以检查JSON的合法性，并把JSON格式化成更友好更可读的格式：

```
cat json_raw.txt | jq .
```

![](http://static.golangtab.com/images/2017-11/24774106_1375357640PQ0C.png)

看到上图，将一团乱麻的JSON格式化成个更可读的形式。其实背后另外检查了JSON的合法性。如果JSON不合法，jq .会报错。我故意写个错误的JSON： 

```
manu@manu:~/code/php/json$ cat json_err.txt 
{"name":"Google","location":{"street":"1600 Amphitheatre Parkway","city":"Mountain View","state":"California","country":"US"},"employees":[{"name":"Michael","division":"Engineering"}{"name":"Laura","division":"HR"},{"name":"Elise","division":"Marketing"}]}
```

上面JSON中加粗和斜体部分，遗漏了一个逗号，所以这个JSON是错误的，jq轻松的可以轻松的检查出来：

```shell
manu@manu:~/code/php/json$ cat json_err.txt |jq .
    parse error: Expected separator between values at line 1, column 183
```

## 2.JSON parse
   如上图json，jq如何解析JSON，根据key获取value？
```
    {
        “key_1”:"value_1",
        “key_2”:"value_2",
    }
    如何根据key获取value？ 
    jq '.key'
```

![](http://static.golangtab.com/images/2017-11/24774106_13753588214y7s.png)

解析不存在的元素，会返回null
```
    echo '{"foo": 42, "bar": "less interesting data"}' | jq .nofoo
    null
```

## 3.JSON nested parse（嵌套解析）

```
 cat json_raw.txt | jq '.location.state'
    "California"
```

##  4.JSON parse array   

```
cat json_raw.txt | jq '.employees[1].name'
    "Laura"
```

## 5.内建函数
  jq还有一些内建函数如 key，has
  key是用来获取JSON中的key元素的：

```
cat json_raw.txt | jq 'keys'
[
  "employees",
  "location",
  "name"
]
```

has是用来是判断是否存在某个key：

```
cat json_raw.txt | jq 'has("name")'
true

cat json_raw.txt | jq 'has("noexisted")'
false
```


与JSON相关的我就暂时介绍到这里，希望进一步了解jq并使用的可以去[http://stedolan.github.io/jq/manual/](http://stedolan.github.io/jq/manual/)，希望了解源码实现的，可以去[https://github.com/stedolan/jq](https://github.com/stedolan/jq)，意料之中的事情是 作者用来flex和bison来parse json。我们的示例JSON来自参考文献第一篇。用google搜索，kernalpanic中有篇文章介绍了jshon和json.sh提供了另外的思路。不过我挺喜欢及


## 参考资料
> - [官网](https://stedolan.github.io/jq/)
> - [How to parse JSON string via command line on Linux](http://xmodulo.com/2013/05/how-to-parse-json-string-via-command-line-on-linux.html)
> - [jq - command-line JSON processor](http://iamsk.info/2013/06/03/jq/)

