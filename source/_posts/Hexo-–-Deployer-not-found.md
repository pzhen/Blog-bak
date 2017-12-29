---
title: Hexo – 'Deployer not found'
toc: true
date: 2017-07-21 14:03:27
share: true
tags:
 - Hexo
categories:
 - Hexo
---

重新部署了Hexo，结果无法部署，解决方法如下：

``` shell
npm install hexo-deployer-git --save
```

照片墙的语法

```
{% stream %}
{% figure https://img1.doubanio.com/lpic/s8869768.jpg [万物生光辉](https://book.douban.com/subject/10519369/) %}
{% figure https://img1.doubanio.com/lpic/s4386309.jpg [我亲爱的甜橙树](https://book.douban.com/subject/4826530/) %}
{% figure https://img1.doubanio.com/lpic/s27971327.jpg [台北人](https://book.douban.com/subject/26253699/) %}
{% endstream %}
```
