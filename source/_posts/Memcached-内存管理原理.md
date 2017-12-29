---
title: Mem - 内存管理原理
toc: true
date: 2017-08-01 13:24:08
share: true
tags:
 - Memcached
 - 原理
categories:
 - Memcached
---

内存管理中一个令人头痛的问题就是内存碎片管理。操作系统、虚拟机垃圾回收在这方面<!-- more -->
想了许多方法：压缩、复制。Memcached使用了一个非常简单的办法---固定空间分配。

Memcached 将内存空间分为一组slab，每个slab里面又包含一组chunk，同一个slab里面的
每个chunk的大小是固定的，拥有相同大小的chunk的slab被组织在一起，叫做slab_class，
如图所示。

存储数据时根据数据的size大小，寻找一个大于size的最小chunk
将数据写入。这种内存管理方式避免了内存碎片的管理问题，内存
的分配和释放都是以chunk为单位的。和其他缓存一样，memcached
采用LRU算法释放最近最久未被访问的数据占用的空间，释放的
chunk被标记为魏永，等待下一个合适大小数据的写入。

当然这种方式也会带来内存浪费的问题。数据只能存入一个比他大的
chunk里，而一个chunk只能存一个数据，其他的空间被浪费了。
如果启动参数配置不合理，浪费会更加惊人，发现没有缓存多少
数据，内存空间就用尽了。

![image](http://static.golangtab.com/images/2017-08/Image.png)