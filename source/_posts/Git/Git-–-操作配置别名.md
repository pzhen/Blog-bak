---
title: Git – 操作配置别名
toc: true
date: 2017-07-21 16:40:57
share: true
tags:
 - Git
 - 别名
categories:
 - Git
---

有没有经常敲错命令？比如Git status？status这个单词真心不好记。

如果敲git st就表示git status那就简单多了，当然这种偷懒的办法我们是极力赞成的。

我们只需要敲一行命令，告诉Git，以后st就表示status：
```
$ git config --global alias.st status
```
好了，现在敲git st看看效果。

当然还有别的命令可以简写，很多人都用co表示checkout，ci表示commit，br表示branch：
```
$ git config --global alias.co checkout
$ git config --global alias.ci commit
$ git config --global alias.br branch
```
以后提交就可以简写成：
```
$ git ci -m "bala bala bala..."
```
--global参数是全局参数，也就是这些命令在这台电脑的所有Git仓库下都有用。

在撤销修改一节中，我们知道，命令git reset HEAD file可以把暂存区的修改撤销掉（unstage），重新放回工作区。既然是一个unstage操作，就可以配置一个unstage别名：
```
$ git config --global alias.unstage 'reset HEAD'
```
当你敲入命令：
```
$ git unstage test.py
```
实际上Git执行的是：
```
$ git reset HEAD test.py
```
配置一个git last，让其显示最后一次提交信息：
```
$ git config --global alias.last 'log -1'
```
这样，用git last就能显示最近一次的提交：
```
$ git last
commit adca45d317e6d8a4b23f9811c3d7b7f0f180bfe2
Merge: bd6ae48 291bea8
Author: Michael Liao <askxuefeng@gmail.com>
Date:   Thu Aug 22 22:49:22 2013 +0800

merge & fix hello.py
```