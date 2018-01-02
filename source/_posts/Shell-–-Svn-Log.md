---
title: Shell – Svn Log
toc: true
date: 2017-07-19 16:44:22
share: true
tags:
 - Svn
 - Shell
categories:
 - Linux
 - Shell
---

##### 1.命令繁琐

由于每次查看log需要输入好长的命令，在这里写成shell，方便许多。

```
user_name=$1
few_days_ago=$2

if [ ! -n "$user_name" ]
then
	user_name='xxxxxxxxxxxx'
fi

if [ ! -n "$few_days_ago" ]
then
	few_days_ago=30
fi

start_time=`date -v -"$few_days_ago"d +%Y-%m-%d`
end_time=`date -v +1d +%Y-%m-%d`

svn log -r {$start_time}:{$end_time} -v | sed -n "/$user_name/,/--$/ p"
```
##### 2.使用方法:
将shell加入环境变量，在项目里面:

```
└─[$] <> svnlog.sh  username  days
```
##### 3.默认参数
如果不传参数默认脚本中username,30天的log。