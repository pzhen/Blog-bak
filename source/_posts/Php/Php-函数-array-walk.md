---
title: Php-函数-array_walk()
toc: true
comments: true
share: true
description: false
date: 2017-12-04 17:46:48
tags:
 - Php
categories:
 - Php
---

PHP之提取多维数组指定列的方法

array_walk()方法

array_walk()使用用户自定义函数对数组中的每个元素做回调处理

```php 
    $name_list = array();
    array_walk($arr, function($value, $key) use (&$name_list ){
        $name_list [] = $value['name'];
    });
```

