---
title: Shell – Tail读取中间行
toc: true
date: 2017-08-03 15:43:26
share: true
tags:
 - Shell
 - Tail
categories:
 - Linux
 - Shell
---

linux 如何显示一个文件的某几行(中间几行)<!-- more -->

``` shell
#从第3000行开始，显示1000行。即显示3000~3999行
cat filename | tail -n +3000 | head -n 1000 
 
# sed  5-10 行
sed -n '5,10p' filename
```
