---
title: Shell – Grep 常见用法
toc: true
date: 2017-07-21 16:36:51
share: true
tags:
 - Grep
 - Shell
categories:
 - Linux
 - Shell
---

是一种强大的文本搜索工具，它能使用正则表达式搜索文本，并把匹配的行打印出来。
我经常用来查找字符串比如：

``` shell
    grep -rn "字符串" .
```

递归查找当前目录下所有文件中 “字符串” 并且所在标出所在行。

下面来看看具体参数：
``` shell
    grep [-acinv] [--color=auto] '搜寻字符串' filename 选项参数:
    -a :将 binary 档案以 text 档案方式搜寻数据
    -c :计算找刡 '搜寻字符串' 次数
    -i :忽略大小写
    -n :输出行号
    -v :反向选择，亦即显示出没有 '搜寻字符串' 内容癿那一行! --color=auto :可以将找刡癿关键词部分加上颜色癿显示!
    -A :后面可加数字，为 after 癿意思，除了列出该行外，后续的 n 行也列出; 
    -B :后面可加数字，为 befer 癿意思，除了列出该行外，前面的 n 行也列出;
```

grep 只支持基础正则表示法，若要延伸型正则，则要用egrep或者  grep -E。

基础正则表示法总结如下：

``` shell
    ^word：查找字符串(word)在行首  grep -n '^word' filename
    word$:  查找字符串(word)在行末  grep -n 'word$' filename
    . : 任意字符
    \ : 转译
    *：前面字符 0 到 任意多个
    [] : 字符集合
    [n1-n2] : 范围  如[0-9]
    [^]: 字符取反，就是不能是里面的字符
    \{n,m\}: 出现n到m次
```

延伸正则表示总结如下：

``` shell
    +  ：一个或者一个以上
    ？ ：零个或者一个
    |   ： 或
    ()  :  群组   egrep -n 'g(la|oo)d' filename  找出 glad 或者 good 两个字符串
    ()+:  群组出现一次或者多次
```
grep 还有很多高级用法，请感兴趣的自己去补给，我只列出了基础的常见的用法。