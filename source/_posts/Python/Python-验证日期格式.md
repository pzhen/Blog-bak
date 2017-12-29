---
title: Python - 验证日期格式
toc: true
date: 2017-08-03 15:18:46
share: true
tags:
 - Python
 - 日期格式
categories:
 - Python
---

``` python
import re
print re.search(r'\d{4}-\d{2}-\d{2}', 'xxxx1990-12-20xxxx').group(0)
print re.search(r'\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}', 'xxxx2005-06-04T18:37:11xxxx').group(0)
print re.search(r'\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}.\d{3}', 'xxxx2005-06-04T18:37:11.111xxxx').group(0)
 
pattern=re.compile(r'(\d{4}-\d{2}-\d{2})((T\d{2}:\d{2}:\d{2}|))((.\d{3})|)')
print pattern.search('xxxx2005-06-04T18:37:11.111xxxx').group(0)
```

