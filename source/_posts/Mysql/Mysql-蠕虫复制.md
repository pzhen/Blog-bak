---
title: Mysql - 蠕虫复制
toc: true
date: 2017-07-31 17:22:04
share: true
tags:
 - Mysql
categories:
 - Mysql
---

快速复制表中记录。<!-- more -->

``` sql
INSERT INTO `table` (`id`,`aa`,`bb`,`cc` ) SELECT '','aa内容','bb注意cc符号区别',`cc` FROM `table` (WHERE .....)
```

