---
title: Mysql - Varchar类型
toc: true
date: 2017-07-31 18:01:18
share: true
tags:
 - Mysql
 - Varchar
categories:
 - Mysql
---

mysql varchar类型。<!-- more -->

> 1.varchar存储规则：
    5.0版本以上，varchar(20)，指的是20字符，无论存放的是数字、字母还是UTF8汉字（每个汉字3字节），都可以存放20个.
    上面测试过了如果超过20个字符mysql截取前20个插入
    但是 最大大小是65532字节 也就是 varchar字节最大65535，utf8编码一个字符3个字节65535/3=21785。汉字不能超过21785.

> 2.关于varchar与set 类型中存储的字符串使用','隔开时
    可以采用:SELECT * FROM `表名` WHERE FIND_IN_SET('要找的字符串',`字段`);这种写法来找出;
    最多可以有64个成员  枚举最多有65535种不同值