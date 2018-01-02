---
title: Golang - Vscode安装依赖插件
toc: true
comments: true
share: true
date: 2017-11-16 13:20:45
tags:
 - Golang
 - Vscode
 - Go
categories:
 - Golang
description: false
---
<style>
.posts-expand .post-body img {
    padding: 0px;
    border: 0px solid #ddd;
}
.posts-expand .post-body .fancybox img {
    /* margin: 0 -9%; */
}
</style>

![](http://static.golangtab.com/images/2017-11/home-screenshot-mac-lg-2x.png)

<!-- <img src="http://static.golangtab.com/images/2017-11/home-screenshot-mac-lg-2x.png" class="full-image" /> -->

<!-- more -->

Visual Studio Code is a lightweight but powerful source code editor which runs on your desktop and is available for Windows, macOS and Linux. It comes with built-in support for JavaScript, TypeScript and Node.js and has a rich ecosystem of extensions for other languages (such as C++, C#, Java, Python, PHP, Go) and runtimes (such as .NET and Unity). Begin your journey with VS Code with these introductory videos.

## 插件简介

vscode-go是VSCode编辑器上非常好用的一个go插件，它包括以下特性：
 - Colorization 代码着彩色
 - Completion Lists 代码自动完成（使用gocode）
 - Snippets 代码片段
 - Quick Info 快速提示信息（使用godef）
 - Goto Definition 跳转到定义（使用godef）
 - Find References 搜索参考引用（使用go-find-references）
 - File outline 文件大纲（使用go-outline）
 - Workspace symbol search 工作区符号搜索（使用 go-symbols）
 - Rename 重命名（使用gorename）
 - Build-on-save 保存构建（使用go build和go test）
 - Format 代码格式化（使用goreturns或goimports或gofmt）
 - Add Imports 添加引用（使用 gopkgs）
 - Debugging 调试代码（使用delve）




## 安装插件

```
https_proxy=127.0.0.1:1087 go get -u -v github.com/nsf/gocode
https_proxy=127.0.0.1:1087 go get -u -v github.com/rogpeppe/godef
https_proxy=127.0.0.1:1087 go get -u -v github.com/golang/lint/golint
https_proxy=127.0.0.1:1087 go get -u -v github.com/lukehoban/go-outline
https_proxy=127.0.0.1:1087 go get -u -v sourcegraph.com/sqs/goreturns
https_proxy=127.0.0.1:1087 go get -u -v golang.org/x/tools/cmd/gorename
https_proxy=127.0.0.1:1087 go get -u -v github.com/tpng/gopkgs
https_proxy=127.0.0.1:1087 go get -u -v github.com/newhook/go-symbols
https_proxy=127.0.0.1:1087 go get -u -v golang.org/x/tools/cmd/guru
```


