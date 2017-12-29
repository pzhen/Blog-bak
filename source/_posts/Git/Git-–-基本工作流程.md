---
title: Git – 基本工作流程
toc: true
date: 2017-07-21 16:30:48
share: true
tags:
 - Git
categories:
 - Git
---


git的基本流程如下：

#### 首先获取项目

为了得一个项目的拷贝(copy),我们需要知道这个项目仓库的地址(Git URL). Git能在许多协议下使用，所以Git URL可能以ssh://, http(s)://, git://. 有些仓库可以通过不只一种协议来访问。


例如ssh方式获取远程你在阿里云下的项目：git clone git@code.aliyun.com:username/xxxx(项目).git

另一种方式是还没有仓库，我们要把当前文件夹设为项目仓库 ：git init  

在当前目录下就会有 .git 的文件夹了。

#### 修改项目

- 创建或修改文件
- 使用git add命令添加新创建或修改的文件到本地的缓存区（Index）
- 使用git commit命令提交到本地代码库
- （可选，有的时候并没有可以同步的远端代码库）使用git push命令将本地代码库同步到远端代码库
