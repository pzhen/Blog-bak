---
title: MongoDB - 增删改
toc: true
comments: true
share: true
date: 2017-08-16 17:48:08
tags:
- MongoDB
categories:
- MongoDB
---

### 增

>db.demo.insert({...})

批量插入效率高于单条插入，因为避免了多次零碎的请求所带来的开销，无需处理大量的消息头，数据库就不需要一遍遍的处理相同
消息头，提高了效率，但是文档总共不能超过16MB，所以有大小限制，批量更新到一个集合而不是同时多个集合。<!-- more -->

### 删

>db.demo.remove({...})

加参数删除符合条件的，不加就是删除所有，不会删除集合本身以及索引。


### 改

>db.demo.update({...})


未完待续...






