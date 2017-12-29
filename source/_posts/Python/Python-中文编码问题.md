---
title: Python - 中文编码问题
toc: true
date: 2017-07-20 11:10:21
share: true
tags:
 - Python
categories:
 - Python
---
#### 文件编码

Python中默认的编码格式是 ASCII 格式，在没修改编码格式时无法正确打印汉字，所以在读取中文时会报错。

解决方法为只要在文件开头加入 # -*- coding: UTF-8 -*- 或者 #coding=utf-8 就行了。

```
#!/usr/bin/python
# -*- coding: UTF-8 -*-
print "你好，世界";
```

所以如果大家在学习过程中，代码中包含中文，就需要在头部指定编码。

注意：Python3.X 源码文件默认使用utf-8编码，所以可以正常解析中文，无需指定 UTF-8 编码。

如果你使用编辑器，同时需要设置好编辑器的编码，如 Pycharm 设置步骤：

- 1.进入 file > Settings，在输入框搜索 encoding。
- 2.找到 Editor > File encodings，将 IDE Encoding 和 Project Encoding 设置为utf-8。

#### 编码之间的转换

例如 类Unix系统上编写的python，如果放到windows下面执行，比如输出的信息包含中文，就需要转换了，
不管是 gb2312 转 utf8 还是 utf8 转 gb2312 都需要现将字符串转换成Unicode的编码，然后再转换成
正确的编码例如：
```
print "2.结算表格读取完成".decode('utf-8').encode('gb2312')
```
将输出的提示语utf8转成gb2312。

#### print list 中文
如果查看print list 的时候里面中文也显示正确，方便调试可这样：
```
import uniout
```
引入该包 就可以显示list中的中文了。