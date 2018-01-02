---
title: Shell – Wget 克隆网站
toc: true
date: 2017-07-31 16:14:22
share: true
tags:
 - Linux
 - Shell
 - Wget
categories:
 - Linux
 - Shell
---

有时候觉得网上看到的漂亮的模板，想下载怎么办哈哈哈wget就搞定了。

<!-- more -->
``` shell
wget -k -p -nH -N http://www.baidu.com
```

-k   把已下载文件中的所有链接都转换为本地引用，不在依赖原始或在线内容

-p   下载所有必要文件，确保离线可用，包括图片和样式表

-nH  禁止把文件下载到以主机名为前缀的文件夹中。

-N   启用文件的时间戳,以匹配来源的时间戳.