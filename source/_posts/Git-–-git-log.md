---
title: Git – git log
toc: true
comments: true
share: true
description: false
date: 2017-12-29 13:28:06
tags:
 - Git
categories:
 - Git
---

![](http://static.golangtab.com/images/2017-11/better-git-log.jpg)

```
git log  命令是查看全部提交日志  
git log -2  查看最近2次的提交日志  
git log -p  查看历史纪录以来哪几行被修改  
git log --stat --summary 查看每个版本变动的档案和行数
```

简要复习完毕，一般来说，默认的 git log 命令就是黑咕噜噜的，挺难看。

![](http://static.golangtab.com/images/2017-11/Screen-Shot-2013-08-15-at-1.11.28-AM.png)

如果你厌倦了上面这颜色，想换换，很简单，在终端输入下面这行代码就OK了。

```
git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit 
```

上面这段是不是有点长，咳咳，那我们就来做一个简单的 alias 吧，科普：alias是linux的一个好东东，可以将很长长长长的命令，用比较短的命令代替，比如: d 等于 ls 、la 等于 ls -a 、md 等于 mkdir 等等。
打开终端，给上面的命令弄一个别名叫 git lg 吧。

```
git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
```


现在你每次在终端输入git lg，就能看到下面漂亮的git log了。

![](http://static.golangtab.com/images/2017-11/Screen-Shot-2013-08-15-at-12.51.10-AM.png)

如果你想看到git log的变化的行数，请输入

```
git lg -p  
```




## 参考资料
> - [更好的git log](http://blog.csdn.net/n289950578/article/details/24465663)

