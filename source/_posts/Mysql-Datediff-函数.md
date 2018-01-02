---
title: Mysql - Datediff()函数
toc: true
date: 2017-08-01 11:18:30
share: true
tags:
 - Mysql
 - Datediff
categories:
 - Mysql
---

DATEDIFF() 函数返回两个日期之间的天数。<!-- more -->

DATEDIFF(date1,date2)

事例：
``` sql

SELECT *
FROM con_contract
WHERE
    datediff(
        FROM_UNIXTIME(remindtime, '%Y-%m-%d'),CURDATE()
    ) = {$limit_time} and state = 3 and archivestate <> 4 and archivestate <> 5";
```


