---
title: Shell – SSH自动登录
toc: true
date: 2017-07-19 22:58:13
share: true
tags:
 - SSH
 - Shell
categories:
 - Linux
 - Shell
---

最近由于频繁操作vps，发现每次输入密码太费劲，所以写了个自动登录shell脚本。

#### 1.创建脚本 xxx.sh
```
#!/usr/bin/expect
set timeout 30
spawn ssh -l root ip地址
expect "password:"
send "密码\r"
```
#### 2.将脚本目录加入环境变量

export PATH=/Users/zhen/Documents/shell:$PATH
这样一来在命令行随时可以调用脚本远程登录。


