---
title: MongoDB - 入门
toc: true
comments: true
share: true
date: 2017-08-16 15:28:52
tags:
- MongoDB
categories:
- MongoDB
---

#### 文档

文档是Mongodb的核心概念。多个键以及关联的值有序的放置在一起便是文档。注意：<!-- more -->

1. 这里的文档中键值对是有序的不同于编程语言中的数据结构比如散列，映射，字典。python的字典,javascript中的对象，等。

2. 键不能为\0(空字符)

3. . 还有 * 有特殊含义，被保留

4. 下划线"_"开头的也是保留的

5. 区分类型，区分大小写

#### 集合

一组文档，如果数据库中的行/记录。

##### 无模式

因为一个集合可以含有各种类型的文档。都可以组成一个集合，那我们还需要分不同的集合吗。答案肯定是要分的。

- 将各式各样的文档放到一个集合里面，造成集合混乱，开发与维护成为噩梦。

- 查询一个特定类型的文档速度上会降低。

- 将同种类型的文档放到一起，使数据更加集中。

- 创建索引的时候，文档通常会有附加结构，索引是按照集合来定义的，同种类型的同一个集合，会使索引更有效。


##### 命名

不能空字符(\0),空字符串"",不能以 system开头，不能含有$。

###### 子集合

使用 "." 字符分开的命名空间划分子集合。例如: blog.post  blog.author  blog集合不一定存在，其实就是按照业务划分。


#### 数据库

多个文档成集合，多个集合成库。独立的数据库，则就有独立的权限管理。

命名规则：

- 不能 "", \0, 空格, ., \, /, $
 
- 全部小写（数据库名字其实映射到文件系统里面的文件夹）

- 最多 64个字节

保留的数据库：

 - admin 用户权限等相关
 
 - local 限于本地单台服务器任意集合
 
 - config 分片时候使用
 

把数据库的名字加到刚才的blog.post 之前 就是集合的完全限定名：myblog.blog.post

#### MongoDB的启动

可以写个脚本 mongodb-start.sh
```shell
#!/bin/bash
#Author:zhen
#Blog:http:www.golangtab.com
#Time:2017-08-09 16:32:07
#Name:mongodb-start.sh
#Version:V1.0
#Description:This is a test script.

mongod --dbpath /Users/zhen/opt/mongodb-osx-x86_64-3.4.2/data/
```

- 默认端口 27017

- 默认data路径 /data/db 采用 --dbpath  来指定

#### 客户端
1. 可以用Mongodb shell 

```shell
./mongo
```

2. 可以采用第三方的可视化工具

[robo3t](http://www.golangtab.com/software/robo3t-1.1.1-darwin-x86_64-c93c6b0.dmg)


3. 基本命令

```shell   

> show dbs            #查看所有数据库
admin  0.000GB
local  0.000GB
> use demo            #不存在则创建demo数据库
switched to db demo
> show dbs
admin  0.000GB
local  0.000GB
> db                  #查看当前数据库
demo


我们刚创建的数据库 demo 并不在数据库的列表中， 要显示它，我们需要向 demo 数据库插入一些数据。

> db.demo.insert({"name":"你好"})
WriteResult({ "nInserted" : 1 })


> db.demo.find()
{ "_id" : ObjectId("5994003d99e250beb1b16f22"), "name" : "你好" }


> db.demo.findOne()
{ "_id" : ObjectId("5994003d99e250beb1b16f22"), "name" : "你好" }



> db.demo.update({"name":"你好"},{"name":"你好","age":30})
WriteResult({ "nMatched" : 1, "nUpserted" : 0, "nModified" : 1 })


> db.demo.findOne()
{ "_id" : ObjectId("5994003d99e250beb1b16f22"), "age" : 30 }


>db.demo.remove() #无参数则删除所有


>help

>db.help()

>db.demo.update  #不加括号出现函数的帮助文档

```

#### 数据库类型

##### 数字

32位整数，64位整数，64位浮点数

##### 日期

```
> new Date()
ISODate("2017-08-16T09:09:09.727Z")
> Date()
Wed Aug 16 2017 17:09:15 GMT+0800 (CST)

```
注意一个是字符串，一个是对象。

##### 数组

```
{"things":["pie",3.14]}
```

##### 内嵌文档

```
{"things":{"name":"xiaoming"}}}
```

##### _id 和 ObjectId

每个文档都有唯一的_id,来唯一表示文档，ObjectId 是_id 的默认类型。

ObjectId创建方式：

01234567891011

0123 时间戳的后5位，提供了秒级的唯一性。

456  机器编号，主机唯一标识。

78   PID 进程编号。

91011 计数器

前9个字节保证了同一秒不同机器不同进程产生的ObjectId 的唯一性，最后三个字节确保相同进程同一秒产生objectid也不同，

每个进程1秒最多256^3(16777216) 个不同的 objectId,

_id 没有的话自动创建，虽然轻量级的但是总会消耗性能，可以将_id在客户端，也就是程序借助API生成。
