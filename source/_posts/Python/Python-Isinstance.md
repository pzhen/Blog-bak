---
title: Python - Isinstance
toc: true
date: 2017-08-03 15:13:50
share: true
tags:
 - Python
 - Isinstance
categories:
 - Python
---
在Python中只需要使用内置的函数isinstance，使用起来非常简单<!-- more -->

``` python
class objA: 
pass 

A = objA() 
B = 'a','v' 
C = 'a string' 

print isinstance(A, objA) 
print isinstance(B, tuple) 
print isinstance(C, basestring) 
```

