---
title: Git – 全局与局部项目配置
toc: true
date: 2017-07-21 16:34:37
share: true
tags:
 - Git
categories:
 - Git
---

#### Git全局配置的文件
```
cat ~/.gitconfig 
```
上面就是全局配置文件位置。

git config –global <配置名称> <配置的值>  例如：

$ git config --global user.name "用户名"
$ git config --global user.email "邮箱"

#### Git局部项目的配置文件

你可以在项目中使用git config 命令不带 --global 选项来设置. 这会在你当前的项目目录下创建 .git/config，从而使用针对当前项目的配置。

