---
title: Shell – 正则表达式
toc: true
date: 2017-07-21 17:00:23
share: true
tags:
 - Shell
 - 正则
categories:
 - Linux
 - Shell
---

#### 正则表达式的分类

- 基本的正则表达式（Basic Regular Expression 又叫Basic RegEx 简称BREs）
- 扩展的正则表达式（Extended Regular Expression 又叫Extended RegEx 简称EREs）
- Perl的正则表达式（Perl Regular Expression 又叫Perl RegEx 简称PREs）

#### 基本组成部分

正则表达式的基本组成部分。

![image](http://static.golangtab.com/images/2017-08/WX20170517-1442082x.png)


#### POSIX字符类

POSIX字符类是一个形如[:…:]的特殊元序列（meta sequence），他可以用于匹配特定的字符范围。

![image](http://static.golangtab.com/images/2017-08/WX20170517-1440442x.png)

#### 元字符

元字符（meta character）是一种Perl风格的正则表达式，只有一部分文本处理工具支持它，并不是所有的文本处理工具都支持。

![image](http://static.golangtab.com/images/2017-08/WX20170517-1443312x.png)


文章来源：http://man.linuxde.net/docs/shell_regex.html 