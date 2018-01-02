---
title: Php - 逐行读取文件
toc: true
date: 2017-08-03 15:38:04
share: true
tags:
 - Php
 - 读取文件
categories:
 - Php
---

PHP逐行读取数据<!-- more -->

``` php
<?php
$file = fopen("Minot.txt", "r") or exit("Unable to open file!");
//Output a line of the file until the end is reached
//feof() check if file read end EOF
while(!feof($file))
{
 //fgets() Read row by row
 echo fgets($file). "<br />";
}
fclose($file);
?>
```
